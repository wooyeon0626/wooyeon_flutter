import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_name.dart';
import 'package:wooyeon_flutter/screens/main_screen.dart';

import '../../utils/transition.dart';

class LoginIsNotWorking extends StatelessWidget {
  const LoginIsNotWorking({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '페이지 즉시 이동(임시)',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                navigateHorizontally(
                  context: context,
                  widget: const RPName(),
                );
              }, child: const Text("프로필 등록")),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  navigateHorizontally(
                    context: context,
                    widget: const MainScreen(),
                  );
                }, child: const Text("메인페이지")),
              ),
            ],),
          ),
        ],
      ),
    );
  }

}