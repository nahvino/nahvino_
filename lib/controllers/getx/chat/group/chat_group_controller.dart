import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatGroupController extends GetxController {
  TextEditingController chat_text = TextEditingController();
  RxBool serach_mood = false.obs;
  RxBool select_mood = false.obs;
  RxBool checkbox = false.obs;
  RxBool emojiShowing = true.obs;
  RxBool keybord = true.obs;
  RxBool canSend = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  ky(BuildContext context) {
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
      FocusScope.of(context).unfocus();

      print("بالا");
    } else {
      //FocusScope.of(context).unfocus();

      emojiShowing.value = !emojiShowing.value;

      print("پایین");
    }
  }

  onEmojiSelected(Emoji emoji) {
    chat_text
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chat_text.text.length));
  }

  onBackspacePressed() {
    chat_text
      ..text = chat_text.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chat_text.text.length));
  }

  void _checkKEyboardAndEmojiVisibility() {
    if (emojiShowing.isTrue) {
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
        emojiShowing.value = false;
      }
    }
  }
}
