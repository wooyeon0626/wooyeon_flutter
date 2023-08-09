import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({Key? key}) : super(key: key);

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker>
    with SingleTickerProviderStateMixin {
  bool _isMale = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50), // Animation duration shortened
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: MediaQuery.of(context).size.width - 80, // Width reduced
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(35),
          ),
          child: Stack(
            alignment: Alignment.center, // Stack centered
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100), // Animation duration shortened
                left: _controller.value * (MediaQuery.of(context).size.width - 80) / 2,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 70,
                  decoration: BoxDecoration(
                    color: _isMale ? Colors.blue : Colors.pink,
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _controller.reverse().then((value) => setState(() {
                        _isMale = true;
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0), // increase as needed
                      child: Text(
                        '남자',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _isMale ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4,),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _controller.forward().then((value) => setState(() {
                        _isMale = false;
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0), // increase as needed
                      child: Text(
                        '여자',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _isMale ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}