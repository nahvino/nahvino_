import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

/*
class MenuPopUp {
  List<FocusedMenuItem> menuItems;
  MenuPopUp({required this.menuItems});
  menu_pop_up(BuildContext context) {
    return IconButton(
        onPressed: () {
          //menu_item();
        },
        icon: Icon(Icons.menu));
  }

  menu_item(BuildContext context) {
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

      /*  
      <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text("تنظیمات"),
            trailingIcon: Icon(Icons.settings),
            onPressed: () {}),
        FocusedMenuItem(
            title: Text("لینک گروه"),
            trailingIcon: Icon(Icons.share),
            onPressed: () {}),
        FocusedMenuItem(
            title: Text(
              "خروج",
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            onPressed: () {}),
      ],

      */
      onPressed: () {},
      child: Icon(Icons.more_vert_rounded),
    );
  }
}
*/
class MenuPopUp extends StatelessWidget {
  const MenuPopUp({Key? key, required this.menuItems}) : super(key: key);
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
      /*  
      <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text("تنظیمات"),
            trailingIcon: Icon(Icons.settings),
            onPressed: () {}),
        FocusedMenuItem(
            title: Text("لینک گروه"),
            trailingIcon: Icon(Icons.share),
            onPressed: () {}),
        FocusedMenuItem(
            title: Text(
              "خروج",
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            onPressed: () {}),
      ],

      */
      onPressed: () {},
      child: Icon(Icons.more_vert_rounded),
    );
  }
}
