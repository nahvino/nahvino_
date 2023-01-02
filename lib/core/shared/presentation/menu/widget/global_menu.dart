import 'package:Nahvino/core/shared/presentation/menu/widget/global_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class GlobalMenu extends StatelessWidget {
  const GlobalMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=> showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          context: context,
          builder: (context) => GlobalMenuItem()), icon: Icon(
      Iconsax.menu_14,
      color: Colors.cyan,
    ),

    );
  }
}
