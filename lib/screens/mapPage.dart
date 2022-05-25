import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inmedic/constants.dart';
import 'package:inmedic/domain/provider.dart';
import 'package:inmedic/main.dart';
import 'package:provider/provider.dart';
import '../widgets/barra.dart';
import 'HomePage.dart';
import 'dart:async';
import 'location_service.dart';
import '../widgets/appbar.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapPage extends StatefulWidget {
  @override
  State<mapPage> createState() => mapPageState();
}

class mapPageState extends State<mapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Location currentLocation = Location();
  bool _isLoading = false;
  Set<Marker> markers = Set();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.019051, -74.850385),
    zoom: 14.4746,
  );

  void getLocation() async {
    setState(() {
      _isLoading = true;
    });
    await currentLocation.getLocation().then((pos) {
      _kGooglePlex = CameraPosition(
        target: LatLng(
          pos.latitude!,
          pos.longitude!,
        ),
        // zoom: pos.altitude!,
        zoom: 12,
      );
      getMarkers(
        LatLng(
          pos.latitude!,
          pos.longitude!,
        ),
      );
      debugPrint(
          "## coord: ${pos.latitude}, ${pos.longitude}, ${pos.altitude}");
    });

    setState(() {
      _isLoading = false;
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(11.019051, -74.850385),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void getMarkers(LatLng location) {
    final provider = Provider.of<ProviderBloc>(context, listen: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderBloc>(context, listen: false);
    return (_isLoading)
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                backgroundColor: KColor.darkGreenBackground,
                title: Text("Mi ubicación"),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios))),
            body: Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: provider.getMarkers(),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ],
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: _goToTheLake,
            //   label: Text('To the lake!'),
            //   icon: Icon(Icons.directions_boat),
            // ),
          );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];

    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
