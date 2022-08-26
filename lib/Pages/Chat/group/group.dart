import 'package:Nahvino/Pages/Chat/fake_info/model_user.dart';
import 'package:Nahvino/Pages/Chat/group/chat_group.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Group extends StatelessWidget {
  Group({Key? key}) : super(key: key);
  Imageview img = Imageview();
  String? imagegrup;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: fakegroup.length,
        itemBuilder: chatItem,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget chatItem(context, index) {
    return Column(
      children: [
        InkWell(
          onTap: (() => Get.to(ChatGroup(
                idgroup: "1",
              ))),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        (imagegrup != null &&
                                imagegrup != "" &&
                                imagegrup != "null")
                            ? img.image(imagegrup!)
                            : img.image_assetsa(fakegroup[index].image!),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Footnate(
                                  text: fakegroup[index].name!,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Footnate(
                                  text: "اعضاء: ",
                                ),
                                Caption1(
                                  text: fakegroup[index].manber!,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Footnate(
                                  text: "تماشاگران: ",
                                ),
                                Caption1(
                                  text: fakegroup[index].viewer!,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Caption1(
                                  text: "رئیس: ",
                                ),
                                Caption1(
                                  text: fakegroup[index].nameadmin!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 2, top: 4),
                            child: Caption1(
                              text: fakegroup[index].lastmass!,
                            ),
                          ),
                        ),
                        Caption1(
                          text: fakegroup[index].time!,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
