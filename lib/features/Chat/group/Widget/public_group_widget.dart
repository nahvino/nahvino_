import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/TextField/public_text_filde.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:Nahvino/features/Chat/group/create_group/screen/page1_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicGroupWidget {
  Imageview img = Imageview();
  String? image1;
  String? image2;
  String? image3;
  String? adminname;
  String? support1;
  String? support2;

  PublicGroupWidget(
      {this.image1,
      this.image2,
      this.image3,
      this.adminname,
      this.support1,
      this.support2});

  img_name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            (image1 != null && image1 != "" && image1 != "null")
                ? img.image(image1!)
                : img.image_assets(),
            Callout(
                color: Colors.teal,
                textAlign: TextAlign.center,
                text: support1!)
          ],
        ),
        Column(
          children: [
            (image2 != null && image2 != "" && image2 != "null")
                ? img.image(image2!)
                : img.image_assets(),
            Callout(
                color: Colors.teal,
                textAlign: TextAlign.center,
                text: support2!)
          ],
        ),
        Column(children: [
          (image3 != null && image3 != "" && image3 != "null")
              ? img.image(image3!)
              : img.image_assets(),
          Callout(
              color: Colors.teal, textAlign: TextAlign.center, text: adminname!)
        ]),
      ],
    );
  }

  hardjoin(BuildContext context, double value_join) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Callout(
          text: "سختی عضویت ",
        ),
        Container(
          width: width / 1.1,
          child: LinearProgressIndicator(
            minHeight: 30,
            backgroundColor: Colors.grey.shade100,
            color: Colors.cyan,
            value: value_join,
          ),
        ),
      ],
    );
  }

  information(String menber, String menbers, String flag, String win) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: menbers,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد تماشاگران گروه",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 10,
            ),
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: menber,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد اعضا گروه",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: win,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد فتح تا اکنون",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 10,
            ),
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: flag,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد پرچمدار های فعلی",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ],
    );
  }

  hradandbtn(String hardnumber) {
    return Row(
      children: [
        Caption1(
          text: hardnumber,
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          width: 3,
        ),
        Caption1(
          text: " : سختی عضویت",
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  notification() {
    bool? isSwitched = false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Switch(
              onChanged: (bool value) {},
              value: isSwitched,
            ),
            SizedBox(
              width: 35,
            ),
            Footnate(
                textAlign: TextAlign.end,
                color: Colors.black,
                text: "بیصدا کردن"),
          ],
        )
      ],
    );
  }

  details_group(BuildContext context, String rulos, String about, String diet) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
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
                  child: Caption1(
                    text: rulos,
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
                  child: Caption1(
                    text: about,
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
                  child: Caption1(
                    text: diet,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Body(text: " :قول و قرار"),
            ],
          )),
          SizedBox(
            height: height * 0.03,
          ),
        ],
      ),
    );
  }

  informationtow(String menbers, String flag) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: menbers,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد اعضای فعلی",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Caption1(
              text: "نفر",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: flag,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              width: 5,
            ),
            Caption1(
              text: "تعداد پرچمدارن",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ],
    );
  }

  suport(String image, String namesupport1, String caption,
      VoidCallback onPressed) {
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        Callout(
            color: Colors.black, textAlign: TextAlign.center, text: caption),
        SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Callout(
                    color: Colors.teal,
                    textAlign: TextAlign.center,
                    text: namesupport1),
                (image != null && image != "" && image != "null")
                    ? img.image(image)
                    : img.image_assets(),
              ],
            ),
            TextButton(
              onPressed: onPressed,
              child: Callout(
                  color: Colors.blue,
                  textAlign: TextAlign.center,
                  text: "جایگزینی معاون اول "),
            )
          ],
        ),
      ],
    );
  }

  textfilde(
      String caption, BuildContext context, TextEditingController txcontroller,
  {    FormFieldValidator<String>? validator,
  }) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: TextFormField(
          minLines: 1,
          maxLines: 3,
          maxLength: 255,
          validator: validator,
          decoration: InputDecoration(
            labelText: caption,
            isDense: false,
            filled: true,
            // border: OutlineInputBorder(),
          ),
          controller: txcontroller,
        ),
      ),
    );
  }

  namegroup(TextEditingController namegroup, BuildContext context,) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      width: width / 1.35,
      child: PublicTextFilde(
        hint: "نام گروه",
        controller: namegroup,
      ),
    );
  }

  btnappbarhome() {
    return TextButton(
        onPressed: () => Get.to(CreateGroup()),
        child: Row(
          children: [
            Subhead(
              color: Colors.blueAccent,
              text: "ایجاد گروه",
            ),
            SizedBox(
              width: 3,
            ),
            Icon(Icons.create, color: Colors.blueAccent),
          ],
        ));
  }

  searchmood({required ValueChanged<String>? changed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.shade700,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 19),
          child: TextFormField(
            onChanged: changed,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Vazirmatn_Medium',
                color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Vazirmatn_Medium',
                  color: Colors.white),
              hintText: "جستوجو",
            ),
          ),
        ),
      ),
    );
  }
}
