import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatGroupController extends GetxController {
  GetStorage settings = GetStorage();
  TextEditingController chat_text = TextEditingController();
  RxBool serach_mood = false.obs;
  RxBool select_mood = false.obs;
  RxBool admin_select_mood = false.obs;
  RxBool checkbox = false.obs;
  RxBool emojiShowing = true.obs;
  RxBool keybord = true.obs;
  RxBool canSend = true.obs;
  RxDouble size_text = 12.0.obs;
  FocusNode focusNode = FocusNode();
  Icon icomke = Icon(Icons.emoji_emotions_outlined);
  Color? color;
  
  final List<String> fonts = [
    "Vazirmatn_SemiBold",
    "Vazirmatn_Regular",
    "Vazirmatn_Medium"
  ];
  Rx<List<String>> selectedfonts = Rx<List<String>>([]);
  RxString selectedfont = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (settings.read("text") == null) {
      settings.write("text", size_text.value);
    } else {
      size_text.value = settings.read("text");
    }
    ;
    if (settings.read("font") == "") {
      settings.write("font", selectedfont.value);
    } else {
      selectedfont.value = settings.read("font");
    }
    ;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojiShowing.value = true;
        icomke = Icon(Icons.emoji_emotions_outlined);
      }
    });
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

  sizes_text() {}
}
