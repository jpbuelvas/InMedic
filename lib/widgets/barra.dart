// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/screens/HomePage.dart';
import 'package:inmedic/screens/chat_view.dart';
import 'package:inmedic/screens/doctors_view.dart';
import '../screens/mapPage.dart';
import '../screens/HomePage.dart';
import '../screens/doctor.dart';
import '../screens/location_service.dart';

class BarNavigetor extends StatefulWidget {
  const BarNavigetor({Key? key}) : super(key: key);

  @override
  State<BarNavigetor> createState() => _BarNavigetorState();
}

class _BarNavigetorState extends State<BarNavigetor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  child: new Container(
                    child: Icon(
                      Icons.favorite_border,
                      color: KColor.darkGreenBackground,
                      size: 35,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorsView(
                              showFavorites: true,
                            )));
                  },
                ),
                GestureDetector(
                  child: new Container(
                    child: Icon(
                      Icons.home,
                      color: KColor.darkGreenBackground,
                      size: 35,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                GestureDetector(
                  child: new Container(
                    child: Icon(
                      Icons.search,
                      color: KColor.darkGreenBackground,
                      size: 35,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => mapPage()));
                  },
                ),

                // GestureDetector(
                //   child: new Container(
                //     child: Icon(
                //       Icons.chat_outlined,
                //       color: KColor.darkGreenBackground,
                //       size: 35,
                //     ),
                //   ),
                //   onTap: () {
                //     print("chat");
                //     // Navigator.of(context).push(
                //     // MaterialPageRoute(builder: (context) => ChatView()));
                //   },
                // ),
                GestureDetector(
                  child: new Container(
                    child: Icon(
                      Icons.person_outline,
                      color: KColor.darkGreenBackground,
                      size: 35,
                    ),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
