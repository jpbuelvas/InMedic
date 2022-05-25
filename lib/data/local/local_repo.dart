import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inmedic/data/models/doctor.dart';
import 'package:inmedic/screens/doctor.dart';

class LocalRepo {
  List<Doctor> getDoctors() {
    return [
      Doctor(
        name: 'Juan Camilo zuluaga',
        specialism: 'Otorrino',
        score: 4.9,
        numberOfReview: 280,
        phone: '312 7331037',
        description: 'Doctor Otorrinolaringologo con 5 años de experiencia',
        favorite: false,
      ),
      Doctor(
        name: 'Miguel Castro Vargas',
        specialism: 'Medico general',
        score: 4.7,
        numberOfReview: 150,
        phone: '312 7331037',
        description: 'Medico General con 7 años de experiencia',
        favorite: false,
      ),
      Doctor(
        name: 'Nicolas Maquiavelo',
        specialism: 'Omeopata',
        score: 4.8,
        numberOfReview: 250,
        phone: '312 7331037',
        description: 'Doctor Omeopata con 8 años de experiencia',
        favorite: false,
      ),
      Doctor(
        name: 'Jose Luis Garzon',
        specialism: 'Pediatra',
        score: 4.3,
        numberOfReview: 500,
        phone: '312 7331037',
        description: 'Pediatra con 5 años de experiencia en su area',
        favorite: false,
      ),
      Doctor(
        name: 'Ana Maria Rozo',
        specialism: 'Ortopedista',
        score: 4.9,
        numberOfReview: 290,
        phone: '312 7331037',
        description: 'Doctora Ortopedista con 7 años de experiencia',
        favorite: false,
      ),
      Doctor(
        name: 'Diana Benitez Cortez',
        specialism: 'Dentista',
        score: 4.6,
        numberOfReview: 210,
        phone: '312 7331037',
        description: 'Doctor Dentista con 5 años de experiencia',
        favorite: false,
      ),
    ];
  }

  Set<Marker> getMarkers() {
    Set<Marker> markers = Set();
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("drog - 1"),
      position: LatLng(11.015645, -74.847071), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Drogería IMedic',
        snippet: 'Drogería',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("drog - 2"),
      position: LatLng(11.015719, -74.846551), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Drogería IMedic sede 2',
        snippet: 'Drogería',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("clinic - 1"),
      position: LatLng(11.015869, -74.846300), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Clínica Porto Azul',
        snippet: 'Drogería',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("clinic - 2"),
      position: LatLng(11.013183, -74.847799), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Clínica Cardiológica',
        snippet: 'Cardiología',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add second marker
      markerId: MarkerId("opto - 1"),
      position: LatLng(11.015153, -74.827826), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Optica IMedic',
        snippet: 'Optica',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("lab - 1"),
      position: LatLng(11.001140, -74.812888), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Laboratorio IMedic',
        snippet: 'Laboratorio',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add second marker
      markerId: MarkerId("dent - 1"),
      position: LatLng(11.013946, -74.836234), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Clínica Odontológica',
        snippet: 'Odontología',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return markers;
  }

  Set<Marker> getMarkerByType(String type) {
    final markers = getMarkers();
    final Set<Marker> filteredMarkers =
        markers.where((marker) => marker.infoWindow.snippet == type).toSet();
    return filteredMarkers;
  }
}
