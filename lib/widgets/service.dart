import 'package:flutter/material.dart';
import 'package:inmedic/screens/mapPage.dart';
import '../screens/location_service.dart';

service(context, String nombre, String url) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      // color: const Color(0xFF00AFC1),

      // height: MediaQuery.of(context).size.height * 0.22,
      // width: MediaQuery.of(context).size.width / 4,
      child: GestureDetector(
          onTap: () {
            getPlaceId(nombre);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => mapPage(),
            ));
          },
          child: Column(children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Image.asset(
                      url,
                      // width: 70,
                      // height: 70,
                    ),
                  ),
                  Text(
                    nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF006d77),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ])));
}
