import 'package:flutter/material.dart';

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
            '그러게요 왜 안될까요...',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 모달 닫기
              },
              child: Text('모달 닫기'),
            ),
          ),
        ],
      ),
    );
  }

}