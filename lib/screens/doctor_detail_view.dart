import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/domain/auth_provider.dart';
import 'package:inmedic/screens/chat_view.dart';
import 'package:inmedic/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/doctor.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  final Doctor doctor;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      // appBar: encabezado(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            widget.doctor.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: KColor.darkBlueText,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.doctor.specialism,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: KColor.greenText,
                      ),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset(
                        "assets/img/doctor1.png",
                        width: 131,
                        height: 140,
                      ),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        actionButton(
                          onTap: () {
                            final tel = Uri.parse('tel:${widget.doctor.phone}');
                            launchUrl(tel);
                          },
                          ImagePath: "assets/img/standard_phone.png",
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        actionButton(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatView(
                                      chatId: widget.doctor.name,
                                    )));
                          },
                          ImagePath: "assets/img/standard_chat.png",
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: KColor.lightGreenBackground,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "About Doctor",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: KColor.darkBlueText,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/img/estrella.png",
                                    width: 15,
                                    height: 15,
                                  ),
                                  Text('${widget.doctor.score}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      " (${widget.doctor.numberOfReview} Reviews)",
                                      style: TextStyle(
                                          color: KColor.lightGreenText,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse culpa deserunt .",
                            style: TextStyle(
                              color: KColor.greenText,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
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

  InkWell actionButton({required Function onTap, required String ImagePath}) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: KColor.darkGreenBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            ImagePath,
            width: 131,
            height: 140,
          ),
        ),
      ),
    );
  }
}
