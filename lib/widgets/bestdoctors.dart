import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/screens/doctors_view.dart';

import '../data/models/doctor.dart';
import '../screens/doctor_detail_view.dart';

GestureDetector besdoctor(
    Doctor doctor, String url, Function onTap, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DoctorDetails(
          // doctorName: doctor.name,
          // doctorSpecialism: doctor.specialism,
          // doctorQualification: doctor.score,
          // reviewsNumber: doctor.numberOfReview,
          // description: doctor.
          doctor: doctor,
        ),
      ));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              url,
              width: 92.5,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doctor.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: KColor.darkBlueText,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Text(
                  doctor.specialism,
                  textAlign: TextAlign.left,
                  // style: TextStyle(color: const Color(0xFF0032777)),
                  style: TextStyle(
                    color: KColor.greenText,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/img/estrella.png",
                      width: 15,
                      height: 15,
                    ),
                    Text(
                      '${doctor.score}',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: const Color(0xFF0032777)),
                    ),
                    Text(
                      " (${doctor.numberOfReview} Reviews)",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: const Color(0xFF0032777)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  onTap.call(!doctor.favorite);
                },
                child: Icon(
                  (doctor.favorite) ? Icons.favorite : Icons.favorite_border,
                  color: (doctor.favorite) ? Colors.red : Colors.grey,
                ),
              )),
        ],
      ),
    ),
  );
}
