import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
class RequsetGroupWidget extends StatelessWidget {
  const RequsetGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
     height: height  / 4,
      child:  Column(
        children: [
          // Card(
          //   //shape: CircleBorder(),
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     child:
          //     Image(
          //         height: 240,
          //         fit: BoxFit.cover,
          //         image: NetworkImage("https://axprint.com/blog/wp-content/uploads/2020/10/profile00-750x430.jpg"))
          // ),
        Padding(
          padding:  EdgeInsets.only(left: 20,right: 20,top: 20),
          child:
          Flexible(
            child: HeadLine(text: AppLocalizations.of(context)!.translate(
              'dti_grup',
            )!),
          ),),
          Spacer(flex: 1,),
          Padding(
            padding:  EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SizedBox(
                  width: 260,
                  child: Buttonfull(
                    text: "درخواست عضویت",
                    color: Colors.white,
                    onPressed: () async {
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Buttonfull(
                    text: "انصراف",
                    color: Colors.white,
                    onPressed: () async {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
  }
}
