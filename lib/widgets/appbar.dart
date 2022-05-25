import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inmedic/data/data_service/data_service.dart';
import 'package:inmedic/domain/auth_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/authentication.dart';

AuthenticationController authenticationController = Get.find();
encabezado(BuildContext context) {
  final _db = DatabaseService();

  final authProvider = Provider.of<AuthenticationProvider>(context);
  return AppBar(
    title: Text("Hola ${authenticationController.userEmail()}!"),
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF006d77),
    actions: <Widget>[
      // IconButton(icon: Icon(Icons.contact_phone_rounded), onPressed: () {}),
      // IconButton(icon: Icon(Icons.notifications_active), onPressed: () {}),
      // IconButton(icon: Icon(Icons.wechat_rounded), onPressed: () {}),
      IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // authenticationController.logout();
            authProvider.logout();
          }),
    ],
  );
}
