import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/features/Chat/group/info_group/controllers/info_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsGroupWidget extends StatelessWidget {
  DetailsGroupWidget({Key? key}) : super(key: key);
  InfoGroupController info_group_controller = Get.put(InfoGroupController());

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                width: width - 38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height / 70,
                    ),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: (info_group_controller.info!.data!.rules !=
                                    null)
                                ? Caption1(
                                    text:
                                        info_group_controller.info!.data!.rules,
                                    textAlign: TextAlign.justify,
                                  )
                                : Caption1(
                                    text: "",
                                    textAlign: TextAlign.justify,
                                  ),
                          ),
                        ),
                        Body(text: " :قوانین"),
                      ],
                    )),
                    SizedBox(
                      height: height / 70,
                    ),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: (info_group_controller.info!.data!.promise !=
                                    null)
                                ? Caption1(
                                    text: info_group_controller
                                        .info!.data!.promise,
                                    textAlign: TextAlign.justify,
                                  )
                                : Caption1(
                                    text: "",
                                    textAlign: TextAlign.justify,
                                  ),
                          ),
                        ),
                        Body(text: " :درباره گروه"),
                      ],
                    )),
                    SizedBox(
                      height: height / 70,
                    ),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: (info_group_controller
                                          .info!.data!.description !=
                                      null)
                                  ? Caption1(
                                      text: info_group_controller
                                          .info!.data!.description,
                                      textAlign: TextAlign.justify,
                                    )
                                  : Caption1(
                                      text: "",
                                      textAlign: TextAlign.justify,
                                    )),
                        ),
                        Body(text: " :قول و قرار"),
                      ],
                    )),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
