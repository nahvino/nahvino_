import 'package:flutter/material.dart';
/*
class BargDialog extends AlertDialog(

  Future showBargDialog () async{

  }
);

*/

class BargDialog extends StatelessWidget {
  const BargDialog({Key? key, required this.test}) : super(key: key);

  final String test;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
    child: Container(
      // height: 480,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(color: Colors.black, spreadRadius: 2),
          BoxShadow(color: Colors.pink, spreadRadius: 2, blurRadius: 4),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.add),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.card_giftcard),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.all_inclusive_outlined),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.date_range),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.chat),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      height: 30,
                      image: AssetImage("assets/images/home/bbarg.png"),
                    ),
                    Text(test),
                    Icon(Icons.extension),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.red.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image(
                        height: 30,
                        image: AssetImage("assets/images/home/bbarg.png"),
                      ),
                      Text(test),
                      Icon(Icons.add),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                        height: 30,
                        image: AssetImage("assets/images/home/bbarg.png"),
                      ),
                      Text(test),
                      Icon(Icons.card_giftcard),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                        height: 30,
                        image: AssetImage("assets/images/home/bbarg.png"),
                      ),
                      Text(test),
                      Icon(Icons.date_range),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("0"),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("امتیاز کل"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("0"),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("سودمندی برای قبیله"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("0"),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    boxShadow: const [
                      BoxShadow(color: Colors.pink, spreadRadius: 1),
                    ],
                  ),
                  child: Text("زیان برای قبیله"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
