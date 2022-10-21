import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/fake_info/model_user.dart';
import 'package:Nahvino/features/Chat/group/chat_group/screen/chat_group.dart';
import 'package:Nahvino/features/Chat/group/controllers/home_group_controller.dart';
import 'package:Nahvino/features/Chat/group/main/controllers/group_controller.dart';
import 'package:Nahvino/features/Chat/group/main/model/groups_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Nahvino/config/main_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Group extends GetView<GroupController> {
  Group({Key? key}) : super(key: key);
  GroupController group_controller = Get.put(GroupController());
  final HomeGroupController home_group_controller =
      Get.put(HomeGroupController());
  Imageview img = Imageview();
  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<GroupController>(builder: (logic) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: home_group_controller.serchtext.value != "" &&
                    home_group_controller.isInSearchMode.value
                ? group_controller.groups
                    .where((element) => element.data.name!
                        .contains(home_group_controller.serchtext.value))
                    .toList()
                    .length
                : group_controller.groups.length,
            itemBuilder: myGroups,
            physics: NeverScrollableScrollPhysics(),
          );
        }),
        GetBuilder<GroupController>(builder: (logic) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: group_controller.other_groups!.length,
            itemBuilder: OtherGroups,
            physics: NeverScrollableScrollPhysics(),
          );
        }),
      ],
    );
  }

  Widget myGroups(context, index) {
    return Column(
      children: [
        InkWell(
          onTap: (() => group_controller.getChat()),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (group_controller.InSearchMode.value == true)
                      Row(
                        children: [
                          /*
                            (imagegrup != null &&
                                    imagegrup != "" &&
                                    imagegrup != "null")
                                ? img.image(imagegrup!)
                                : img.image_assetsa("assets/images/ram/gorp.png"),
*/
                          Card(
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              cacheManager: CacheManager(Config(
                                  'customCacheKey',
                                  stalePeriod: Duration(days: 7),
                                  maxNrOfCacheObjects: 100)),
                              imageUrl: MainConfig.fileurl +
                                  group_controller.group_model!.data.imageUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Footnate(
                                    text:
                                        group_controller.group_model?.data.name,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    text: "اعضاء: ",
                                  ),
                                  Caption1(
                                    text: "20",
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    text: "تماشاگران: ",
                                  ),
                                  Caption1(
                                    text: "10",
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
                                    text: group_controller
                                        .group_model?.data.ownerName,
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
                          color: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 2, top: 4),
                            child: Caption1(
                              text: group_controller
                                  .group_model?.data.lastMessage,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Caption1(
                          text: group_controller
                              .group_model?.data.lastMessageDateTime,
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

  Widget OtherGroups(context, index) {
    return Column(
      children: [
        InkWell(
          onTap: (() => ""
              // Get.to(ChatGroup(
              //   idgroup: fakegroup[index].id,
              // ))
              ),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (group_controller.InSearchMode.value == true)
                      Row(
                        children: [
                          /*
                            (imagegrup != null &&
                                    imagegrup != "" &&
                                    imagegrup != "null")
                                ? img.image(imagegrup!)
                                : img.image_assetsa("assets/images/ram/gorp.png"),
*/

                          (group_controller.other_group_model?.data?[index]
                                          .imageUrl! !=
                                      null ||
                                  group_controller.other_group_model!
                                          .data![index].imageUrl! !=
                                      "null" ||
                              group_controller.other_group_model!
                                  .data![index].imageUrl! !=
                                  "")
                              ?
                              Card(
                                  shape: CircleBorder(),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImage(
                                    height: 50,
                                    width: 50,
                                    cacheManager: CacheManager(Config(
                                        'customCacheKey',
                                        stalePeriod: Duration(days: 7),
                                        maxNrOfCacheObjects: 100)),
                                    imageUrl: MainConfig.fileurl +
                                        group_controller.other_group_model!
                                            .data![index].imageUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ):img.image_assetsa("assets/images/ram/gorp.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Footnate(
                                    text: group_controller
                                        .other_group_model?.data?[index].name,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    text: "اعضاء: ",
                                  ),
                                  Caption1(
                                    text: "20",
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    text: "تماشاگران: ",
                                  ),
                                  Caption1(
                                    text: "10",
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
                                    text: group_controller
                                        .other_group_model?.data?[index].name,
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
                          color: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 2, top: 4),
                            child: Caption1(
                              text: group_controller
                                  .group_model?.data.lastMessage,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Caption1(
                          text: group_controller
                              .other_group_model?.data?[index].name,
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
