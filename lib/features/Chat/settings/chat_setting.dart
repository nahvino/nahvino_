import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/fake_info/model_user.dart';
import 'package:Nahvino/features/Chat/group/controllers/group/chat_group_controller.dart';
import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ChatSetting extends StatelessWidget {
  ChatSetting({Key? key}) : super(key: key);
  ChatGroupController chat_group_controller = Get.put(ChatGroupController());
  String? test;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.cyan.shade800,
            title: Body(text: "تنظیمات گفت وگو")),
        body: global_body(context),
      );
    });
  }

  Widget global_body(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 7,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            reverse: false,
            itemCount: fakeMassagegroup.length,
            itemBuilder: chatItem,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: width / 15),
          child: HeadLine(
            text: "سایز پیام",
          ),
        ),
        SfSlider(
            showDividers: true,
            min: 10.0,
            max: 30.0,
            value: chat_group_controller.size_text.value,
            interval: 5,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 5,
            onChanged: (dynamic value) {
              chat_group_controller.size_text.value = value;
              chat_group_controller.settings
                  .write("text", chat_group_controller.size_text.value);
            }),
        SizedBox(
          height: 7,
        ),
        Padding(
          padding: EdgeInsets.only(right: width / 15),
          child: HeadLine(
            text: "فونت پیام",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: width / 20, left: width / 20),
          child: DecoratedDropdownButton(
            hint: Footnate(
              text: "تغییر فونت",
            ),
            value: chat_group_controller.fonts[0],
            items: [
              DropdownMenuItem(
                  child: Text("وزیر-زخیم"), value: "Vazirmatn_SemiBold"),
              DropdownMenuItem(
                  child: Text("وزیر-نازک"), value: "Vazirmatn_Regular")
            ],
            onChanged: (value) {
              print("You selected $value");
              chat_group_controller.selectedfont.value = value as String;
              chat_group_controller.settings
                  .write("font", chat_group_controller.selectedfont.value);
            },
            color: Colors.cyan.shade700,
            //background color
            border: Border.all(color: Colors.cyan.shade50, width: 2),
            //border

            borderRadius: BorderRadius.circular(20),
            //border radius
            style: TextStyle(
                //text style
                color: Colors.white,
                fontSize: 20),
            icon: Icon(Icons.arrow_downward),
            //icon
            iconEnableColor: Colors.white,
            //icon enable color
            dropdownColor: Colors.cyan.shade900, //dropdown background color
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Padding(
          padding: EdgeInsets.only(right: width / 15),
          child: HeadLine(
            text: "تم چت",
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Column(
              children: [
                Radio(
                    value: Colors.amberAccent,
                    groupValue: chat_group_controller.color,
                    onChanged: (value) {
                      chat_group_controller.color = value as Color;
                    }),
              ],
            )
          ],
        )
      ]),
    ));
  }

  Widget chatItem(context, index) {
    Massage? chat;
    String myuserid = "a";
    bool fromMe = fakeMassagegroup[index].userid == myuserid;
    return Obx(() {
      return Column(
          crossAxisAlignment:
              fromMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  fromMe ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                //me
                fromMe
                    ? Row(
                        children: [
                          ChatBubble(
                            clipper:
                                ChatBubbleClipper1(type: BubbleType.sendBubble),
                            margin: EdgeInsets.only(top: 4, bottom: 4),
                            backGroundColor: chat_group_controller.color,
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //Title3(text: chat!.mass.toString()),
                                        ChatTextMassgae(
                                            fonts: chat_group_controller
                                                .selectedfont.value,
                                            fontsize: chat_group_controller
                                                        .settings
                                                        .read("text") ==
                                                    null
                                                ? 16
                                                : chat_group_controller.settings
                                                    .read("text"),
                                            text: fakeMassagegroup[index].mass),

                                        ChatTextMassgae(
                                            fonts: chat_group_controller
                                                .selectedfont.value,
                                            fontsize: chat_group_controller
                                                        .settings
                                                        .read("text") ==
                                                    null
                                                ? 16
                                                : chat_group_controller.settings
                                                    .read("text"),
                                            text: fakeMassagegroup[index].time),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Row(
                          children: [
                            ChatBubble(
                              clipper: ChatBubbleClipper2(
                                  type: BubbleType.receiverBubble),
                              backGroundColor: Color(0xffE7E7ED),
                              margin: EdgeInsets.only(top: 4, bottom: 4),
                              child: Column(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.6),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        ChatTextMassgae(
                                            fonts: chat_group_controller
                                                .selectedfont.value,
                                            fontsize: chat_group_controller
                                                .settings
                                                .read("text") ==
                                                null
                                                ? 16
                                                : chat_group_controller
                                                .settings
                                                .read("text"),
                                            text: fakeMassagegroup[index]
                                                .name),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                7.0),
                                            shape: BoxShape.rectangle,
                                            color: Colors.black12,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight:
                                                      Radius
                                                          .circular(
                                                          5),
                                                      topRight: Radius
                                                          .circular(
                                                          5)),
                                                  shape:
                                                  BoxShape.rectangle,
                                                  color:
                                                  Colors.greenAccent,
                                                ),
                                              ),
                                              // Footnate(
                                              //   text: chat
                                              //       .parentMessageUserNameAlias!,
                                              //   ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 5),
                                                child: Column(
                                                  children: [
                                                    ChatTextMassgae(
                                                      fonts:
                                                      chat_group_controller
                                                          .selectedfont
                                                          .value,
                                                      text: "نام",
                                                    ),
                                                    // Caption1(
                                                    //     text: chat.parentMessageText!
                                                    //         .length >
                                                    //         30
                                                    //         ? '${chat.parentMessageText!.substring(0, 30)}...'
                                                    //         : chat
                                                    //         .parentMessageText),
                                                    ChatTextMassgae(
                                                        fonts: chat_group_controller
                                                            .selectedfont
                                                            .value,
                                                        text: "پیام"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ChatTextMassgae(
                                            fonts: chat_group_controller
                                                .selectedfont.value,
                                            fontsize: chat_group_controller
                                                .settings
                                                .read("text") ==
                                                null
                                                ? 16
                                                : chat_group_controller
                                                .settings
                                                .read("text"),
                                            text: fakeMassagegroup[index]
                                                .mass),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            )
          ]);
    });
  }
}
