import 'package:Nahvino/Pages/Chat/fake_info/model_user.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  Person({Key? key}) : super(key: key);
  Imageview img = Imageview();
  String? imagegrup;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: user.length,
        itemBuilder: chatItem,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget chatItem(context, index) {
    User use;
    return Column(
      children: [
        InkWell(
          onTap: (() => ""),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
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
                            : img.image_assetsa(user[index].img!),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Footnate(
                              text: user[index].name!,
                            ),
                            Caption1(
                              text: user[index].mass!,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Caption1(
                      text: user[index].time!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
