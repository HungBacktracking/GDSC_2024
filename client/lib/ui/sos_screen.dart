import 'dart:async';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/scaler.dart';
import '../utils/styles.dart';

final GlobalKey<ScaffoldState> jcbHomekey = GlobalKey();

class SOSScreen extends StatefulWidget {
  const SOSScreen({Key? key}) : super(key: key);

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position? currentPosition;
  Set<Marker> markers = {};
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
      markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Current Location'),
      ));
    });
  }

  Future<void> goToCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
      key: jcbHomekey,
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
              zoom: 15,
            ),
            onMapCreated: onMapCreated,
            markers: markers,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20 * scaler.widthScaleFactor),
                    topRight: Radius.circular(20 * scaler.widthScaleFactor))),
            padding: EdgeInsets.all(16 * scaler.widthScaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you in an emergency?',
                  style: TextStyle(
                    fontSize: 26 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 16 * scaler.widthScaleFactor),
                Text(
                  'Help will arrive shortly',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18 * scaler.widthScaleFactor/ scaler.textScaleFactor,
                  ),
                ),
                SizedBox(height: 25 * scaler.widthScaleFactor),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.red[600],
                      padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
                    ),
                    child: Text(
                      "Find help",
                      style: TextStyle(
                          fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16 * scaler.widthScaleFactor),
              ],
            ),
          ),
          Positioned(
            right: 16 * scaler.widthScaleFactor,
            bottom: 200 * scaler.widthScaleFactor,
            child: Container(
                decoration: BoxDecoration(
                  color: context.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.near_me,
                    color: Colors.blue,
                  ),
                  onPressed: goToCurrentLocation,
                )),
          ),
          Positioned(
            left: 16 * scaler.widthScaleFactor,
            top: (context.statusBarHeight + 16) * scaler.widthScaleFactor ,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: radius(100 * scaler.widthScaleFactor),
                  border: Border.all(
                      color: context.scaffoldBackgroundColor, width: 2 * scaler.widthScaleFactor),
                ),
                child: Image.asset(
                  'assets/icons/ic_profile.png',
                  height: 40 * scaler.widthScaleFactor,
                  width: 40 * scaler.widthScaleFactor,
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(100 * scaler.widthScaleFactor).onTap(() {
                  jcbHomekey.currentState!.openDrawer();
                }, borderRadius: radius(100 * scaler.widthScaleFactor))),
          )
        ],
      ),
    );
  }
}
