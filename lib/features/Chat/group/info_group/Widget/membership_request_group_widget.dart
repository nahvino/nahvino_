import 'package:Nahvino/config/lang/App_localizations.dart';
import 'package:Nahvino/core/Utils/Button/Button.dart';
import 'package:Nahvino/core/Utils/Text/Text.dart';
import 'package:Nahvino/core/Utils/Widget/ui/image_view.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
class MembershipRequestList extends StatelessWidget {
  const MembershipRequestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: 30,
        shrinkWrap: true,
        itemBuilder: requestList_item,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
  Widget requestList_item(context, index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 50, width: 50, child: Imageview().image_assets()),
                  SizedBox(width: 5,),
                  Body(
                    color: Colors.black,
                    text: "علی",
                  )
                ],
              ),
              SizedBox(
                width: 175,
                height: 35,
                child: Buttonfull(
                  text:AppLocalizations.of(context)!.translate(
                    'Accept_request',
                  )!,
                  onPressed: () => "",
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: DottedDecoration(),
        )
      ],
    );
  }
}
