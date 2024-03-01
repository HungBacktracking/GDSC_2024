import 'dart:async';
import 'package:client/ui/sos/sos_screen.dart';
import 'package:client/utils/strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/scaler.dart';

final GlobalKey<ScaffoldState> jcbHomekey = GlobalKey();

class HelperSOSScreen extends StatefulWidget {
  const HelperSOSScreen({Key? key}) : super(key: key);

  @override
  State<HelperSOSScreen> createState() => _HelperSOSScreenState();
}

class _HelperSOSScreenState extends State<HelperSOSScreen> {
  GoogleMapController? mapController;
  late int distanceInMeters;
  final Completer<GoogleMapController> _controller = Completer();
  bool isFinished = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  static const LatLng victimLocation = LatLng(10.78, 106.6649603);

  BitmapDescriptor helperIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor victimIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/green_plus.png").then((icon) {
      helperIcon = icon;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/victim.png").then((icon) {
      victimIcon = icon;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position? currentPosition;
  Set<Marker> markers = {};
  StreamSubscription<Position>? positionStreamSubscription;
  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
    _listenToPositionUpdates();
    setCustomMarkerIcon();
    getPolyPoints();
  }

  void _listenToPositionUpdates() {
    // Cấu hình cho getPositionStream
    const locationOptions = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    // Lắng nghe các cập nhật vị trí
    positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationOptions).listen(
          (Position? position) {
        if (position != null) {
          setState(() {
            currentPosition = position;
            print('Current position: $currentPosition');
            markers.add(Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
              infoWindow: const InfoWindow(title: 'Current Location'),
            ));
            getPolyPoints();
            // Cập nhật marker hoặc thực hiện các thao tác liên quan tới UI ở đây
          });
        }
      },
    );
  }


  @override
  void dispose() {
    // Hủy bỏ subscription khi không cần thiết
    positionStreamSubscription?.cancel();
    super.dispose();
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
      markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        infoWindow: const InfoWindow(title: 'Current Location'),
      ));

      goToCurrentLocation();
      // getPolyPoints();

      // Correctly calculate the distance here after currentPosition is set
      double distance = Geolocator.distanceBetween(
          position.latitude, position.longitude, victimLocation.latitude, victimLocation.longitude);

      distanceInMeters = distance.truncate();

    });
  }


  Future<void> goToCurrentLocation() async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        zoom: 15.0,
      ),
    ));
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    await _getCurrentLocation();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      MyStrings.google_map_api_key,
      PointLatLng(currentPosition!.latitude, currentPosition!.longitude),
      // PointLatLng(10.77, 106.6849603),
      PointLatLng(victimLocation.latitude, victimLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates = [];
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {});
    }
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
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              // target: currentPosition,
              target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
              zoom: 13.0,
            ),
            onMapCreated: onMapCreated,
            markers: {
              Marker(
                markerId: const MarkerId('helper'),
                position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                infoWindow: const InfoWindow(title: 'Your Location'),
                icon: helperIcon,
              ),
              Marker(
                markerId: MarkerId("victim"),
                icon: victimIcon,
                position: victimLocation,
                infoWindow: const InfoWindow(title: 'Victim Location'),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                points: polylineCoordinates,
                color: Colors.green,
                width: 6,
              )
            },
          ),
          Positioned(
            top: 30,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You have ${distanceInMeters}m to reach the need',
                    style: TextStyle(
                      fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            right: 16 * scaler.widthScaleFactor,
            bottom: 130 * scaler.widthScaleFactor,
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
              right: 16 * scaler.widthScaleFactor,
              top: (context.statusBarHeight + 30) * scaler.widthScaleFactor ,
              child: InkWell(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Icon(Icons.clear),
                // child: Text(
                //   'Cancel',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 17 * scaler.widthScaleFactor / scaler.textScaleFactor,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              )
          ),
        ],
      ),
    );
  }
}