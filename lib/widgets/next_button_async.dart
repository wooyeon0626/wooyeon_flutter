import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/utils/transition.dart';

class NextButtonAsync extends StatefulWidget {
  final Widget? nextPage;
  final String text;
  final ValueNotifier<bool> isActive;
  final Function? func;

  const NextButtonAsync(
      {this.nextPage,
      required this.text,
      required this.isActive,
      this.func,
      super.key});

  @override
  State<NextButtonAsync> createState() => _NextButtonAsyncState();
}

class _NextButtonAsyncState extends State<NextButtonAsync> {
  bool isLoading = false;

  Future<void> _onTap(BuildContext currentContext) async {
    if (isLoading) return;

    if (widget.isActive.value) {
      if (widget.func == null && widget.nextPage != null) {
        navigateHorizontally(context: currentContext, widget: widget.nextPage!);
      } else if (widget.func != null && widget.nextPage == null) {
        setState(() {
          isLoading = true;  // 로딩 상태 시작
        });

        await widget.func!();  // 비동기 함수 실행

        if (mounted) {  // 위젯이 여전히 트리에 존재하는지 확인
          setState(() {
            isLoading = false;  // 로딩 상태 종료
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.isActive,
        builder: (BuildContext context, bool isActive, Widget? child) {
          return InkWell(
            onTap: () => _onTap(context),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isActive ? (isLoading ? Palette.inactive : Palette.primary) : Palette.inactive,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: isLoading
                    ? LoadingAnimationWidget.fourRotatingDots(color: Palette.grey, size: 32)
                    : Text(
                  widget.text,
                  style: TextStyle(
                    color: isActive ? Colors.white : Palette.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
