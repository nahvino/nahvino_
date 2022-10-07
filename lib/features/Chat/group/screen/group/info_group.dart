import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Menu/menu_pop.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/dialog_tow_btn.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/Widget/public_group_widget.dart';
import 'package:Nahvino/features/Chat/group/controllers/group/info_group_controller.dart';
import 'package:Nahvino/features/Chat/group/screen/group/edit_group.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class InfoGroup extends StatelessWidget {
  InfoGroup({Key? key}) : super(key: key);
//  InfoTop isto = InfoTop();
  InfoGroupController info_group_controller = Get.put(InfoGroupController());
  Imageview img = Imageview();
  String? imagegrup;

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Obx(
        () => Scaffold(
            appBar: AppBar(
              excludeHeaderSemantics: true,
              primary: true,
              backgroundColor: Colors.cyan.shade800,
              automaticallyImplyLeading: true,
              elevation: 2,
              actions: [
                Row(
                  children: [
                    Footnate(text: "درباره گروه"),
                    SizedBox(
                      width: 8,
                    ),
                    (imagegrup != null &&
                            imagegrup != "" &&
                            imagegrup != "null")
                        ? img.image(imagegrup!)
                        : img.image_assets(),
                    SizedBox(
                      width: 8,
                    ),
                    //menu pop up
                    MenuPopUp(
                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                            title: Footnate(
                              text: "تنظیمات",
                            ),
                            trailingIcon: Icon(Icons.settings),
                            onPressed: () {
                              Get.to(EditGroup());
                            }),
                        FocusedMenuItem(
                            title: Footnate(
                              text: "لینک",
                            ),
                            trailingIcon: Icon(Icons.share),
                            onPressed: () {
                              print("درسته");
                            }),
                        if (info_group_controller.join.value == false)
                          FocusedMenuItem(
                              title: Footnate(
                                color: Colors.redAccent,
                                text: "خروج",
                              ),
                              trailingIcon: Icon(
                                Icons.exit_to_app,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                info_group_controller.leavegroup();
                              }),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
            body: buildChild(context)),
      ),
    );
  }

  buildChild(BuildContext context) {
    PublicGroupWidget public_group = PublicGroupWidget(
        image1: "null",
        image2: "",
        image3: "",
        adminname: "سحر",
        support1: "علی",
        support2: "محمد");
    String a =
        "نباید به طور علنی دعوا کنیم که بچه\n .های بقیه  گروه ها ببینن و";
    String b =
        "داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...داستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...داستان یو می زنی است که یک دروغ کوچک می گوید و درداستان یو می زنی است که یک دروغ کوچک می گوید و در نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد... نهایت به زندگی دیگران می پردازد. هیون جو زنی است که زندگی خود را بالاتر از همه نگه می دارد و با آنها نه با مهربانی و نه با بدخواهی رفتار می کند. او رابطه‌ای تنش‌آمیز دارد...";
    return Obx(
      () => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              public_group.img_name(),
              SizedBox(
                height: 18,
              ),
              public_group.information("65", "625", "7", "9"),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Hard in join
                  public_group.hradandbtn("20"),

                  if (info_group_controller.join.value == false)
                    Container(
                      width: 80,
                      child: Buttonfull(
                        text: "ترک گروه",
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (context) => DialogTowButton(
                                    title: "آیا همچنان مایل به ترک گروه هستید؟",
                                    textbutton: "بله",
                                    titlecancel: "منصرف شدم",
                                    onPressed: () {
                                      print("API Delete Massage");
                                      Navigator.pop(context, true);
                                      info_group_controller.leavegroup();
                                      print(info_group_controller.join);
                                    },
                                  ));
                        },
                        color: Colors.white,
                      ),
                    ),
                  if (info_group_controller.join.value == true)
                    Container(
                      width: 200,
                      child: Buttonfull(
                        text: "ارسال درخواست عضویت",
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (context) => DialogTowButton(
                                    title:
                                        "آیا همچنان مایل به ارسال درخواست عضویت هستید؟",
                                    textbutton: "بله",
                                    titlecancel: "منصرف شدم",
                                    onPressed: () {
                                      print("API Delete Massage");
                                      Navigator.pop(context, true);
                                      info_group_controller.sendrequsetjoin();
                                      print(info_group_controller.join);
                                    },
                                  ));
                        },
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              //isto.hardjoin(context, 0.26),
              //Notfiction
              public_group.notification(),
              Divider(
                height: 2,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
              public_group.details_group(
                  context,
                  "هرشب ساعت 10 جلسه جمعی برگزار می گردد",
                  "داستان کیم ته هیون یک جراح با استعداد است. او که در پرداخت هزینه درمان خواهر بیمارش ناتوان است، نام رمز یونگ پال را برگزیده و مهارت های پزشکی خود را به کسانی که نیاز به مراقبت های پزشکی دارند، اما نمی توانند علنی این کار را انجام دهند، ارائه می دهد.",
                  b),
            ],
          ),
        ),
      ),
    );
  }
}
