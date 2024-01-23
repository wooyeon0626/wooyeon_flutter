import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/chat/chat_detail.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/screens/login/register/register_success.dart';
import 'package:wooyeon_flutter/service/fcm/fcm_service.dart';
import 'package:wooyeon_flutter/service/login/auto_login/auth.dart';
import 'package:wooyeon_flutter/service/login/register/email_auth.dart';
import 'firebase_options.dart';

import 'loading.dart';
import 'models/controller/chat_controller.dart';
import 'models/state/navigationbar_state.dart';
import 'screens/main_screen.dart';
import 'config/palette.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();

  // FCM 토큰 받아오기 from Firebase
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM Token: $fcmToken');
  if(fcmToken != null){
    // FCM 토큰 전송 to Backend
    FcmService.postFcmToken(fcmToken: fcmToken);
  }

  // Foreground 에서 FCM 메세지 수신 직후, 내부 알림 띄우기
  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        debugPrint(message.notification!.title);
        debugPrint(message.notification!.body);
        debugPrint(message.data["type"]);
        // 내부 알림 띄우기
        _showFlutterNotification(message);
      }
    }
  });

  // background 에서 fcm 으로 실행
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        debugPrint(message.notification!.title);
        debugPrint(message.notification!.body);
        debugPrint(message.data["type"]);
        _handleNavigate(message);
      }
    }
  });

  // Terminate
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        debugPrint(message.notification!.title);
        debugPrint(message.notification!.body);
        debugPrint(message.data["type"]);
        _handleNavigate(message);
      }
    }
  });

  initializeDateFormatting('ko_KR', null).then((_) {
    runApp(const MyApp());
  });

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void _showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

// FCM message를 받아 적절한 페이지로 라우팅
_handleNavigate(RemoteMessage message){
  if(message.data['type'] == 'chat'){
    // type == chat 이라면, massage.data['chatRoomId']를 통해 해당 채팅방으로 이동하도록
    Get.find<NavigationBarState>().setInx(3);
    // 이후 특정 채팅방으로 이동
    int chatRoomId = int.parse(message.data['chatRoomId']);
    Get.to(ChatDetail(chatRoomId: chatRoomId));
  }
  else if(message.data['type'] == 'match'){
    // type == match 라면, 바텀 네비게이션바의 '매치'로 이동하도록
    Get.find<NavigationBarState>().setInx(2);
  }
  else{
    debugPrint("_handleNavigate : message.data is missing");
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  final Auth _auth = Auth();
  bool? _isEmailAuth;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initUniLinks();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _initUniLinksForeground();
    }
  }

  _initUniLinks() async {
    final initialLink = await getInitialLink();

    log('[State] initialLink : $initialLink');

    if (initialLink != null) {
      _handleIncomingLink(initialLink);
    }
  }

  _initUniLinksForeground() async {
    final initialLink = await getInitialLink();

    log('[State] initialLink : $initialLink');

    if (initialLink != null) {
      _handleIncomingLinkForeground(initialLink);
    }
  }

  void _verifyTokenWithBackend(String token) async {
    // TODO: 백엔드와 통신하여 토큰 검증
    final String? email = await Pref.instance.get('email_address');

    if(email == null) {
      return;
    } else {
      bool isTokenValid = await EmailAuth().sendEmailVerifyRequest(email: email, token: token);

      setState(() {
        _isEmailAuth = isTokenValid;
        _isLoading = false;
      });
    }
  }

  Future<bool> _verifyTokenWithBackendForeground(String token) async {
    // TODO: 백엔드와 통신하여 토큰 검증
    final String? email = await Pref.instance.get('email_address');

    if(email == null) {
      return false;
    } else {
      bool isTokenValid = await EmailAuth().sendEmailVerifyRequest(email: email, token: token);

      if (isTokenValid) {
        return true;
      } else {
        return false;
      }
    }
  }


  void _handleIncomingLink(String link) {
    final uri = Uri.parse(link);

    log('[State] uri : ${uri.host}');

    if (uri.host == 'email_auth') {
      final token = uri.queryParameters['token'];

      log('[State] token : $token');

      if (token != null) {
        _verifyTokenWithBackend(token);
      }
    }
  }

  void _handleIncomingLinkForeground(String link) {
    final uri = Uri.parse(link);

    log('[State] uri : ${uri.host}');

    if (uri.host == 'email_auth') {
      final token = uri.queryParameters['token'];

      log('[State] token : $token');

      if (token != null) {
        _verifyTokenWithBackendForeground(token).then((value) {
          if(value) {
            Get.to(RegisterSuccess());
          } else {
            Get.to(RegisterEmailInput());
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
      debugShowCheckedModeBanner: false,
      title: '우연',
      theme: ThemeData(
        primaryColor: Palette.primary,
        primarySwatch: ColorService.createMaterialColor(Palette.primary),
        fontFamily: 'Pretendard',
      ),
      home: _isEmailAuth != null ? (_isEmailAuth! ? RegisterSuccess() : RegisterEmailInput()) : FutureBuilder<bool>(
        future: _auth.autoLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const MainScreen();
            } else {
              // Login() 무시, MainScreen 우선 실행
              return const MainScreen();//Login();
            }
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
