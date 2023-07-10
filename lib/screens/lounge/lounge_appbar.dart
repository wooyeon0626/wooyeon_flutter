import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';

class LoungeAppbar extends StatefulWidget {
  const LoungeAppbar({super.key});

  @override
  State<LoungeAppbar> createState() => _LoungeAppbar();
}

class _LoungeAppbar extends State<LoungeAppbar> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(
                    EvaIcons.shoppingBag,
                    color: Palette.lightGrey,
                  ))),
        ),
      ),
    );
  }
}
