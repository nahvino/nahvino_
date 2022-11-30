import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/create_group/controllers/create_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page3Group extends StatelessWidget {
  Page3Group({Key? key}) : super(key: key);
  CreateGroupController creategroupcontroller =
      Get.put(CreateGroupController());
  Imageview img = Imageview();
  PublicGroupWidget public_group = PublicGroupWidget();

  String? imagegrup;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            excludeHeaderSemantics: true,
            primary: true,
            backgroundColor: Colors.cyan.shade800,
            automaticallyImplyLeading: true,
            elevation: 2,
            actions: [
              Row(
                children: [
                  Footnate(text: AppLocalizations.of(context)!.translate(
                    'create_group',
                  )!,),
                  SizedBox(
                    width: 18,
                  ),
                ],
              )
            ],
          ),
          body: buildChild(context)),
    );
  }

  buildChild(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Column(
      children: [
        Form(
          key: creategroupcontroller.formKey1,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // public_group.textfilde(" قوانین گروه : ", context,validator: (value){
              //   if(value == null){
              //     return "قوانین گروه نمی تواند خالی باشد";
              //   }
              // },
              //     creategroupcontroller.rulscontroller),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.translate(
                        'Group_rules_cannot_be_empty',
                      );
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.translate(
                      'group_rules',
                    )!,
                    isDense: false,
                    filled: true,
                    // border: OutlineInputBorder(),
                  ),
                  controller: creategroupcontroller.rulscontroller,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              public_group.textfilde(" قول و قرار : ", context,
                  creategroupcontroller.gholghrarcontroller),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
        Buttonfull(
            text: AppLocalizations.of(context)!.translate(
    'create_group',
    )!,
            color: Colors.white,
            onPressed: () => creategroupcontroller.nextthree()),
      ],
    );
  }
}
