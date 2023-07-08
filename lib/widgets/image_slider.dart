import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;
  final double width;
  final double height;

  const ImageSlider({
    super.key,
    required this.images,
    required this.width,
    required this.height,
  });

  @override
  State<ImageSlider> createState() => _ImageSlider();
}

class _ImageSlider extends State<ImageSlider> {
  final _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.images.length;
          _controller.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        });
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            Container(
              color: Palette.inactive,
              child: const Center(
                  child: Icon(
                EvaIcons.image,
                color: Colors.white,
                size: 96,
              )),
            ),
            PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              // disable manual swipe
              children: [
                for (var i = 0; i < widget.images.length; i++)
                  Center(
                    child: Image.network(
                      widget.images[i],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
              ],
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicators(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicators(BuildContext context) {
    final double totalIndicatorSize = widget.width - 20;
    final double indicatorSize =
        totalIndicatorSize / (widget.images.length + 1) - 4;

    if (widget.images.length < 2) {
      return [];
    }

    return List<Widget>.generate(widget.images.length, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: index == _currentIndex ? indicatorSize * 2 : indicatorSize,
        height: 4,
        decoration: BoxDecoration(
          color: index == _currentIndex
              ? Colors.white
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      );
    });
  }
}

// Center(
// child: Image.network(
// widget.images[index],
// fit: BoxFit.cover,
// width: double.infinity,
// height: double.infinity,
// ),
// );
