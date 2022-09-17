import 'package:Nahvino/Utils/Text/Text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
/*
class MenuPopUpButton extends StatelessWidget {
  const MenuPopUpButton({Key? key, required this.menuItems}) : super(key: key);
  final List<FocusedMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      blurSize: 0.0,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.transparent,
      openWithTap: true,
      menuOffset: 10.0,
      bottomOffsetHeight: 80.0,
      menuItems: menuItems,
      onPressed: () {},
      child: Card(
        elevation: 1,
        color: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const SizedBox(
          width: 75,
          height: 40,
          child: Center(
            child: Footnate(text: 'انتخاب عکس', color: Colors.white),
          ),
        ),
      ),
    );
  }
}

 */
class MenuPopUpButton extends StatelessWidget {
  const MenuPopUpButton({Key? key, required this.menuItems}) : super(key: key);
  final List<FocusedMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      blurSize: 0.0,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.transparent,
      openWithTap: true,
      menuOffset: 10.0,
      bottomOffsetHeight: 80.0,
      menuItems: menuItems,
      onPressed: () {},
      child: Container(height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.black45)
          ),child: Icon(Icons.add))
    );
  }
}