import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:flutter/foundation.dart' as foundation;

class BottomSheetTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onSubmitted;

  const BottomSheetTextField(
      {Key? key, required this.hintText, this.onSubmitted})
      : super(key: key);

  @override
  State<BottomSheetTextField> createState() => _BottomSheetTextField();
}

class _BottomSheetTextField extends State<BottomSheetTextField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  bool _showEmojiPanel = false;

  _onBackspacePressed() {
    final text = _textController.text;
    final textLength = text.length;

    if (textLength > 0) {
      final lastChar = text.codeUnitAt(textLength - 1);

      // Check if the last character is a low surrogate.
      if (lastChar >= 0xdc00 && lastChar <= 0xdfff) {
        // If the last character is a low surrogate, remove the last two characters.
        _textController.text = text.substring(0, textLength - 2);
      } else {
        // If the last character is not a surrogate, remove the last character.
        _textController.text = text.substring(0, textLength - 1);
      }

      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible) {
        setState(() {
          _showEmojiPanel = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showEmojiPanel) {
          setState(() {
            _showEmojiPanel = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _showEmojiPanel
                        ? EvaIcons.messageCircleOutline
                        : EvaIcons.smilingFace,
                    color: Palette.grey,
                  ),
                  onPressed: () {
                    if (_showEmojiPanel) {
                      _textFocusNode.requestFocus();
                      setState(() {
                        _showEmojiPanel = false;
                      });
                    } else if (_textFocusNode.hasFocus) {
                      _textFocusNode.unfocus();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        setState(() {
                          _showEmojiPanel = true;
                        });
                      });
                    } else {
                      _textFocusNode.requestFocus();
                    }
                  },
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 60),
                    child: Center(
                      child: TextField(
                        focusNode: _textFocusNode,
                        controller: _textController,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          setState(() {
                            _showEmojiPanel = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    EvaIcons.arrowCircleRight,
                    color: Palette.primary,
                    size: 32,
                  ),
                  onPressed: () {
                    //debugPrint(_textController.text);
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted!(_textController.text);
                    }
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !_showEmojiPanel,
            child: SizedBox(
              height: 300,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  setState(() {
                    _textController.text = _textController.text + emoji.emoji;
                  });
                },
                onBackspacePressed: () {
                  setState(() {
                    _onBackspacePressed();
                  });
                },
                config: Config(
                  columns: 7,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0),
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Palette.primary,
                  iconColor: Palette.grey,
                  iconColorSelected: Palette.primary,
                  backspaceColor: Palette.primary,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Palette.grey,
                  enableSkinTones: true,
                  recentTabBehavior: RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  noRecents: const Text(
                    '최근에 사용한 이모지가 없어요.',
                    style: TextStyle(fontSize: 16, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                  // Needs to be const Widget
                  loadingIndicator: const SizedBox.shrink(),
                  // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
