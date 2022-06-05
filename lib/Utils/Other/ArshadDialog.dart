import 'package:flutter/material.dart';
import '../Text/TextField.dart';
import '../Text/Text.dart';
/*
class BargDialog extends AlertDialog(

  Future showBargDialog () async{

  }
);

*/

class ArshadDialog extends StatelessWidget {
  const ArshadDialog({Key? key}) : super(key: key);

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
    child: Column(
      children: [
        Container(
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 2),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text("ارشد شما در حال حاضر"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("data"),
                                  Icon(Icons.location_pin),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Column(
                                  children: [
                                    Text("data"),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          new BorderRadius.circular(
                                              30.0),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50),
                                                border: Border.all(
                                                    color: Colors.black26,
                                                    width: 1)),
                                            child: textspan(
                                              text: "5",
                                              color: Colors.purpleAccent,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          textspan(
                                            text: "ره رو",
                                            color: Colors.black,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Image(
                                    image: AssetImage(
                                        "assets/images/ram/man1.jpg")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: 480,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, spreadRadius: 2),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text("ارشد شما در حال حاضر"),
                      ),
                      TextSearch(
                        hint: 'جستجوی کاربر',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: null,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Container(
                          width: 480,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade200,
                            shape: BoxShape.rectangle,
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black, spreadRadius: 2),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Scrollbar(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade300,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            100)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text("data"),
                                                      Icon(Icons.location_pin),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  width: 120,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade300,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            100)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text("data"),
                                                      Icon(Icons.location_pin),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                // SizedBox(
                                                //   width: 5,
                                                // ),
                                                Column(
                                                  children: [
                                                    Text("data"),
                                                    Container(
                                                      width: 80,
                                                      height: 30,
                                                      decoration: new BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                          new BorderRadius
                                                              .circular(
                                                              30.0),
                                                          border: Border.all(
                                                              color:
                                                              Colors.black,
                                                              width: 1)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black26,
                                                                    width: 1)),
                                                            child: textspan(
                                                              text: "5",
                                                              color: Colors
                                                                  .purpleAccent,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          textspan(
                                                            text: "ره رو",
                                                            color: Colors.black,
                                                            textAlign:
                                                            TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Image(
                                                    image: AssetImage(
                                                        "assets/images/ram/man1.jpg")),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
