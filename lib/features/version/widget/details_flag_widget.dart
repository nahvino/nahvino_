import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/version/controllers/flag_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlagDetailsWidget extends StatelessWidget {
  FlagDetailsWidget({Key? key}) : super(key: key);
  FlagController flag_controller = Get.put(FlagController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: GetBuilder<FlagController>(
        builder: (logic) {
          return (flag_controller.flagmodel != null)
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 30, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title2(
                            text: "مشخصات اینترنت",
                          ),
                          IconButton(
                              onPressed: () => Navigator.pop(context, true),
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Body(
                              text: "کشور : ",
                            ),
                            Body(
                              text: flag_controller.flagmodel?.country!,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Body(
                              text: "کد کشور : ",
                            ),
                            Body(text: flag_controller.flagmodel?.countryCode!),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Body(
                              text: "کد شهر : ",
                            ),
                            Body(text: flag_controller.flagmodel?.region!)
                          ],
                        ),
                        Row(
                          children: [
                            Body(
                              text: "استان : ",
                            ),
                            Body(text: flag_controller.flagmodel?.regionName!),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Body(
                              text: "شهر : ",
                            ),
                            Body(text: flag_controller.flagmodel?.city!)
                          ],
                        ),
                        Row(
                          children: [
                            Body(
                              text: "منظقه زمانی : ",
                            ),
                            Body(text: flag_controller.flagmodel?.timezone!),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                            child: Body(text: flag_controller.flagmodel?.isp!)),
                        Body(
                          text: " : ISP",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                            child: Body(text: flag_controller.flagmodel?.as!)),
                        Body(
                          text: " : AS",
                        ),
                      ],
                    ),
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
