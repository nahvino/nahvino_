import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/feature_chat/group/chat_group/controllers/chat_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/chat_group/controllers/cnn_chat_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/chat_group/screen/chat_group_screen.dart';
import 'package:Nahvino/features/feature_chat/group/controllers/home_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/info_group_controller.dart';
import 'package:Nahvino/features/feature_chat/group/info_group/controllers/members_controller.dart';
import 'package:Nahvino/features/feature_chat/group/main/controllers/group_controller.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Group extends GetView<GroupController> {
  Group({Key? key}) : super(key: key);
  GroupController group_controller = Get.put(GroupController());
  ChatGroupController chat_group_controller = Get.put(ChatGroupController());
  InfoGroupController infoGroupController = Get.put(InfoGroupController());
  ConnectionChatGroupController connChatController =
      Get.put(ConnectionChatGroupController());

  MembersListController membersListController =
      Get.put(MembersListController());

  final HomeGroupController home_group_controller =
      Get.put(HomeGroupController());
  Imageview img = Imageview();
  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<GroupController>(builder: (logic) {
          return Column(
            children: [
              (group_controller.my_groups_model != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                    home_group_controller.serchtext.value != "" &&
                              home_group_controller.isInSearchMode.value
                          ? group_controller.myGroups_list
                              .where((element) => element.data.name!.contains(
                                  home_group_controller.serchtext.value))
                              .toList()
                              .length
                          : group_controller.myGroups_list.length,
                      itemBuilder: myGroups,
                      physics: NeverScrollableScrollPhysics(),
                    )
                  : Container(),
            ],
          );
        }),
        Container(
          decoration: DottedDecoration(),
        ),
        GetBuilder<GroupController>(builder: (logic) {
          return (group_controller.other_group_model != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: home_group_controller.serchtext.value != "" &&
                          home_group_controller.isInSearchMode.value
                      ? group_controller.other_groups_list
                          .where((element) => element.data.name!
                              .contains(home_group_controller.serchtext.value))
                          .toList()
                          .length
                      : group_controller.other_groups_list.length,
                  //group_controller.other_groups.length
                  itemBuilder: OtherGroups,
                  physics: NeverScrollableScrollPhysics(),
                )
              : Lottie.asset('assets/anim/chat/chat_loading.json',
                  height: 450, width: 600);
        }),
      ],
    );
  }

  //گروه خودم
 /* Widget myGroups(context, index) {
    var theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: (() {
            connChatController.id.value =
                group_controller.groups[index].data.id!;
            chat_group_controller.serach_mood.value = false;
            chat_group_controller.select_mood.value = false;
            infoGroupController
                .start_service(group_controller.groups[index].data.id!);
            membersListController
                .start_service(group_controller.groups[index].data.id!);
            Get.to(() => ChatGroup());
            chat_group_controller.appbarname.value =
                group_controller.groups[index].data.name!;
            chat_group_controller.appbarimage.value =
                group_controller.groups[index].data.imageUrl!;
            print(chat_group_controller.appbarimage.value);
          }),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
            ),
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
                              imageUrl:
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
                                    color: theme.secondaryHeaderColor,
                                    text:
                                        group_controller.group_model?.data.name,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                        AppLocalizations.of(context)!.translate(
                                      'Members',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller.group_model?.data
                                            .numberMessageNoSeen ??
                                        "0",
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                        AppLocalizations.of(context)!.translate(
                                      'Audience',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller.groups[index].data
                                            .numberMessageNoSeen ??
                                        "0",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                        AppLocalizations.of(context)!.translate(
                                      'Boss',
                                    )!,
                                  ),
                                  Caption1(
                                      color: theme.secondaryHeaderColor,
                                      text: group_controller
                                          .groups[index].data.ownerName),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 30,
                          child: Card(
                            color: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Footnate(
                                color: theme.secondaryHeaderColor,
                                text: "12",
                                //group_controller.group_model?.data.lastMessage ?? "0",
                              ),
                            ),
                          ),
                        ),
                        Caption1(
                          color: theme.secondaryHeaderColor,
                          text: group_controller
                                  .groups[index].data.lastMessageDateTime ??
                              "00:00",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Divider(
        //   thickness: 1,
        // )

        Container(
          decoration: DottedDecoration(),
        )
      ],
    );
  }*/

  Widget myGroups(context, index) {
    var theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: (() {
            chat_group_controller.serach_mood.value = false;
            chat_group_controller.select_mood.value = false;
            infoGroupController.start_service(
                group_controller.myGroups_list[index].data.id!.toInt());
            membersListController.start_service(
                group_controller.myGroups_list[index].data.id!.toInt());
            Get.to(() => ChatGroup());
            chat_group_controller.appbarname.value =
                group_controller.myGroups_list[index].data.name.toString();
            chat_group_controller.appbarimage.value =
                group_controller.myGroups_list[index].data.imageUrl.toString();
            connChatController.id.value =
            group_controller.myGroups_list[index].data.id!;
            connChatController.getMessageGroup(
                group_controller.myGroups_list[index].data.id!.toInt());
            connChatController.sendMessage();
          }),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              top: 20,
              bottom: 20,
              left: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (group_controller.InSearchMode.value == true)
                      Row(
                        children: [
                          (group_controller.myGroups_list[index].data.imageUrl !=
                              null)
                              ? img.image(group_controller
                              .myGroups_list[index].data.imageUrl!)
                              : img.image_assetsa("assets/images/ram/gorp.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .myGroups_list[index].data.name,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Members',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .myGroups_list[index].data.count
                                        .toString(),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Audience',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
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
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Boss',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .myGroups_list[index].data.ownerName,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 30,
                          child: Card(
                            color: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Footnate(
                                color: theme.secondaryHeaderColor,
                                text: group_controller.myGroups_list[index].data
                                    .numberMessageNoSeen ??
                                    "10",
                              ),
                            ),
                          ),
                        ),
                        Caption1(
                          color: theme.secondaryHeaderColor,
                          text: group_controller
                              .myGroups_list[index].data.lastMessageDateTime
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: DottedDecoration(),
        ),
      ],
    );
  }

  Widget OtherGroups(context, index) {
    var theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: (() {
            chat_group_controller.serach_mood.value = false;
            chat_group_controller.select_mood.value = false;
            infoGroupController.start_service(
                group_controller.other_groups_list[index].data.id!.toInt());
            membersListController.start_service(
                group_controller.other_groups_list[index].data.id!.toInt());
            Get.to(() => ChatGroup());
            chat_group_controller.appbarname.value =
                group_controller.other_groups_list[index].data.name.toString();
            chat_group_controller.appbarimage.value =
                group_controller.other_groups_list[index].data.imageUrl.toString();
            connChatController.id.value =
            group_controller.other_groups_list[index].data.id!;
            connChatController.getMessageGroup(
                group_controller.other_groups_list[index].data.id!.toInt());
            connChatController.sendMessage();
          }),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              top: 20,
              bottom: 20,
              left: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (group_controller.InSearchMode.value == true)
                      Row(
                        children: [
                          (group_controller.other_groups_list[index].data.imageUrl !=
                              null)
                              ? img.image(group_controller
                              .other_groups_list[index].data.imageUrl!)
                              : img.image_assetsa("assets/images/ram/gorp.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .other_groups_list[index].data.name,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Members',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .other_groups_list[index].data.count
                                        .toString(),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Footnate(
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Audience',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
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
                                    color: theme.secondaryHeaderColor,
                                    text:
                                    AppLocalizations.of(context)!.translate(
                                      'Boss',
                                    )!,
                                  ),
                                  Caption1(
                                    color: theme.secondaryHeaderColor,
                                    text: group_controller
                                        .other_groups_list[index].data.ownerName,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 30,
                          child: Card(
                            color: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Footnate(
                                color: theme.secondaryHeaderColor,
                                text: group_controller.other_groups_list[index].data
                                    .numberMessageNoSeen ??
                                    "10",
                              ),
                            ),
                          ),
                        ),
                        Caption1(
                          color: theme.secondaryHeaderColor,
                          text: group_controller
                              .other_groups_list[index].data.lastMessageDateTime
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: DottedDecoration(),
        ),
      ],
    );  }
}
