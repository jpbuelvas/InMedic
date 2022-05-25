// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/domain/provider.dart';
import 'package:inmedic/screens/doctors_view.dart';
import 'package:provider/provider.dart';
import '../widgets/barra.dart';

import '../widgets/appbar.dart';
import '../widgets/bestdoctors.dart';
import '../widgets/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<ProviderBloc>(context, listen: false);
    provider.getDoctorList();
    debugPrint("## doctors in dispose: ${provider.doctors.length}");

    super.initState();
  }

  @override
  void dispose() {
    debugPrint("statement");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: encabezado(context),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            foco(size, context),
            // Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Servicios",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: const Color(0xFF006d77),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: servicios(size, context),
            ),
            // Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "TOP-Doctores",
                      style: TextStyle(
                        color: KColor.darkBlueText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "Ver Todos",
                        style: TextStyle(
                          color: KColor.darkBlueText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        final value =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorsView(),
                        ));
                        setState(() {
                          provider.doctors;
                        });
                      },
                    ),
                  ]),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: topdoctors(provider),
                ),
              ),
            ),
            BarNavigetor(),
          ],
        ));
  }

  topdoctors(ProviderBloc provider) {
    return new Column(
        children: provider.doctors.asMap().entries.take(3).map((doctor) {
      return besdoctor(
          doctor.value,
          (doctor.key.isEven)
              ? 'assets/img/doctor1.png'
              : 'assets/img/doctor2.png', (fav) {
        debugPrint("## did tap fav homepage");
        doctor.value.favorite = fav;
        setState(() {
          doctor;
        });
      }, context);
    }).toList());
  }

  servicios(Size size, BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            service(context, "Odontologia", "assets/img/diente.png"),
            service(context, "Cardiologia", "assets/img/corazon.png"),
            service(context, "Drogueria", "assets/img/drug.png"),
            service(context, "Ambulancia", "assets/img/ambulance.png"),
            service(context, "Laboratorio", "assets/img/microscope.png"),
            service(context, "Optometria", "assets/img/optometria.png"),
          ],
        ));
  }

  foco(Size size, BuildContext context) {
    Color c = const Color(0xFF006d77);
    Color cc = const Color(0xFF0032777);
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        // height: size.height * 0.25,
        decoration: new BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 8, 8, 8),
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ]),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                // FittedBox(
                // fit: BoxFit
                // .fill, // the picture will acquire all of the parent space.
                // child: Text(
                //   "¿Ya completaste tu\n\n"
                //   "esquema de vacunacion\n\n"
                //   "contra el Covid 19?\n\n",
                //   style: TextStyle(color: Colors.white),
                // ),
                // child: Text(
                Expanded(
                  flex: 10,
                  child: Text(
                    "¿Ya completaste tu "
                    "esquema de vacunación"
                    "contra el Covid 19?",
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                // ),
                Expanded(
                  flex: 8,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Colors.white,
                    child: Container(
                      child: const Text(
                        'Centros de Vacunacion',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF006d77),
                        ),
                      ),
                    ),
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, 'home');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1, //increase to fill more space of picture
            child: Image.asset("assets/img/covid.jpg"),
          ),
        ]),
      ),
    );
  }
}
