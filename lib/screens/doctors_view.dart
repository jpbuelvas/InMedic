import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/domain/provider.dart';
import 'package:inmedic/widgets/appbar.dart';
import 'package:inmedic/widgets/bestdoctors.dart';
import 'package:provider/provider.dart';

import '../data/models/doctor.dart';

class DoctorsView extends StatefulWidget {
  DoctorsView({
    Key? key,
    this.showFavorites = false,
  }) : super(key: key);
  bool showFavorites;

  @override
  State<DoctorsView> createState() => DoctorsViewState();
}

List<Doctor> _getFavorites(List<Doctor> doctors) {
  return doctors.where((doctor) => doctor.favorite == true).toList();
}

class DoctorsViewState extends State<DoctorsView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderBloc>(context, listen: true);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: encabezado(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                Container(
                  color: KColor.darkGreenBackground,
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
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
                                color: KColor.darkBlueText,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              (widget.showFavorites)
                                  ? "Doctores Favoritos"
                                  : "Top - Doctores",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: KColor.darkBlueText,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: (widget.showFavorites)
                            ? (_getFavorites(provider.doctors).isEmpty)
                                ? Center(
                                    child: Text(
                                      "Aun no tienes doctores favoritos",
                                      style: TextStyle(
                                          color: KColor.lightGreenText,
                                          fontSize: 15),
                                    ),
                                  )
                                : Column(
                                    children: _getFavorites(provider.doctors)
                                        .asMap()
                                        .entries
                                        .map((doctor) {
                                      return besdoctor(
                                          doctor.value,
                                          (doctor.key.isEven)
                                              ? 'assets/img/doctor1.png'
                                              : 'assets/img/doctor2.png',
                                          (fav) {
                                        setState(() {
                                          doctor.value.favorite = fav;
                                        });
                                      }, context);
                                    }).toList(),
                                  )
                            : Column(
                                children: provider.doctors
                                    .asMap()
                                    .entries
                                    .map((doctor) {
                                  return besdoctor(
                                      doctor.value,
                                      (doctor.key.isEven)
                                          ? 'assets/img/doctor1.png'
                                          : 'assets/img/doctor2.png', (fav) {
                                    setState(() {
                                      doctor.value.favorite = fav;
                                    });
                                  }, context);
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
