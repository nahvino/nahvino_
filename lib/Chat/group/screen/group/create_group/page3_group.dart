import 'package:Nahvino/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/Chat/group/controllers/group/create_group_controller.dart';
import 'package:Nahvino/Utils/Button/Button.dart';
import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:Nahvino/Utils/Widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

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
                  Footnate(text: "ایجاد گروه"),
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
                      return "قوانین گروه نمی تواند خالی باشد";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "قوانین گروه",
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
            text: "ایجاد گروه",
            color: Colors.white,
            onPressed: () => creategroupcontroller.nextthree()),
      ],
    );
  }
}
