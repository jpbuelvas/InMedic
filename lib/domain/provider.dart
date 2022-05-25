import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inmedic/data/local/local_repo.dart';
import 'package:inmedic/data/models/doctor.dart';

class ProviderBloc extends ChangeNotifier {
  final LocalRepo repo = LocalRepo();
  List<Doctor> doctors = [];
  final String key = 'AIzaSyBjdoUvHy_9GP6eQvZnvcV0Qa6Ml_P5ozE';
  void getDoctorList() {
    doctors = repo.getDoctors();
    debugPrint("## doctors in provider: ${doctors.length}");
  }

  Set<Marker> getMarkers() {
    return repo.getMarkers();
  }
}
