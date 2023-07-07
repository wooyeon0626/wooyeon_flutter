import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

// whenever your initialization is completed, remove the splash screen:
// FlutterNativeSplash.remove();

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '우연',
      home: MainScreen(),
    );
  }
}
