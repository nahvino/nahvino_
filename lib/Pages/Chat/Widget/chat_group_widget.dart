import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChatGroupWidget {
 

  search_mood() {}
  select_mood() {}
  massgae_box() {}
  send_message() {}
  icon_message(bool offstage, OnBackspacePressed onbackspacepressed,
      OnEmojiSelected onemojiselected) {
    return Offstage(
      offstage: offstage,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            onEmojiSelected: onemojiselected,
            // (Category category, Emoji emoji) {
            // },
            onBackspacePressed: onbackspacepressed,
            config: Config(
                columns: 7,
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                progressIndicatorColor: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 28,
                //noRecentsText: 'No Recents',
                //  noRecentsStyle:
                //    const TextStyle(fontSize: 20, color: Colors.black26),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL)),
      ),
    );
  }

  text_group(
      ValueChanged<String>? onChanged, TextEditingController controller, FocusNode? focusNode) {
    return Expanded(
        child: TextField(
      showCursor: true,
      enableSuggestions: true,
      autocorrect: true,
      enableInteractiveSelection: true,
      enableIMEPersonalizedLearning: true,
      scribbleEnabled: true,
      mouseCursor: MouseCursor.uncontrolled,
      focusNode: focusNode,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "پیام خود را بنویسید"),
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      autofocus: false,
      maxLines: 5,
      minLines: 1,
      enabled: true,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 16, fontFamily: 'Vazirmatn_Light'),
      controller: controller,
    ));
  }

  menu_appbar() {}
  replay() {}
}
