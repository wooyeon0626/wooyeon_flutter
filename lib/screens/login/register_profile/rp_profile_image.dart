import 'dart:developer';
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyeon_flutter/screens/login/login/login_success.dart';
import 'package:wooyeon_flutter/service/login/register/profile_register.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../utils/notifier.dart';
import '../../../utils/transition.dart';
import '../../../widgets/next_button_async.dart';
import '../login.dart';

class RPImage extends StatefulWidget {
  const RPImage({super.key});

  @override
  State<RPImage> createState() => _RPImageState();
}

class _RPImageState extends State<RPImage> {
  final buttonActive = ValueNotifier<bool>(false);
  final ScrollController _scrollController = ScrollController();
  final List<XFile> _imageFiles = [];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // 이미지 압축
      var result = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        "${pickedFile.path}_compressed.jpg",
        quality: 50,
      );

      setState(() {
        _imageFiles.add(result!);
      });

      if (_imageFiles.length >= 2) {
        buttonActive.value = true;
      }

      _scrollToEnd();
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });

    if (_imageFiles.length < 2) {
      buttonActive.value = false;
    }
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<List<MultipartFile>> prepareImages(List<XFile> imageFiles) async {
    List<MultipartFile> multiImage = [];

    for (var image in imageFiles) {
      var file = File(image.path);
      var multiPartFile = await MultipartFile.fromFile(file.path, filename: "image_${imageFiles.indexOf(image)}.jpg");
      multiImage.add(multiPartFile);
    }

    return multiImage;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileProgressBar(
                start: 0.875,
                end: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 25, bottom: 25),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    EvaIcons.arrowIosBack,
                    color: Palette.black,
                  ),
                  iconSize: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "당신을 알아가는 시간을 가져볼게요.",
                  style: TextStyle(
                    color: Palette.primary,
                    fontSize: 18,
                    letterSpacing: -2.5,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "사진을 추가해주세요",
                  style: TextStyle(
                      color: Palette.black,
                      fontSize: 32,
                      letterSpacing: -2.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 300,
                    maxHeight: 300,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    children: [
                      ..._imageFiles.asMap().entries.map((entry) {
                        return GestureDetector(
                          onLongPress: () async {
                            _removeImage(entry.key);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              width: 240,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                  image: FileImage(File(entry.value.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      if (_imageFiles.length < 8)
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 240,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Palette.lightGrey,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 48,
                              color: Palette.lightGrey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: Text(
                  "프로필 사진을 2장 이상 업로드 해주세요.\n등록한 사진을 꾹 눌러 제거할 수 있어요!",
                  style: TextStyle(
                    color: Palette.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Builder(
                        builder: (newContext) {
                          final ctx = newContext;

                          return NextButtonAsync(
                              text: "다음",
                              isActive: buttonActive,
                              func: () async {
                                bool isSuccess = await ProfileRegister().sendProfileRequest(await prepareImages(_imageFiles));

                                if(!isSuccess) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showCustomSnackBar(
                                        context: ctx,
                                        text: '업로드 실패. 나중에 다시 시도해주세요!',
                                        color: Palette.red);
                                  });
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    navigateHorizontally(
                                      context: ctx,
                                      widget: LoginSuccess(),
                                    );
                                  });
                                }
                              });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
