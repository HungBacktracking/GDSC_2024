import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../utils/scaler.dart';
import '../../utils/themes.dart';
import 'helper_accept_sos_screen.dart';

class HelperNotificationScreen extends StatelessWidget{
  final String imageUrl;
  final LatLng victimLocation;

  static const routeName = '/helper_notification';
  const HelperNotificationScreen({Key? key, required this.imageUrl, required this.victimLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Scaler().init(context);
    final scaler = Scaler();
    final currentLocation = LatLng(37.33500926, -122.03272188);
    int distanceInMeters =
    Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, victimLocation.latitude, victimLocation.longitude).truncate();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: 16.0 * scaler.widthScaleFactor),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10 * scaler.widthScaleFactor),
                    topRight: Radius.circular(10 * scaler.widthScaleFactor),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Distance to victim: 484 meters',
                      style: TextStyle(
                        fontSize: 24 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
                      child: SizedBox(
                        width: double.infinity,
                        child: SwipeableButtonView(
                          buttonText: 'Swipe to Accept',
                          buttontextstyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          ),
                          buttonWidget: Container(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 40 * scaler.widthScaleFactor,
                            ),
                          ),
                          activeColor: MyTheme.submitBtn,
                          isFinished: false,
                          onWaitingProcess: () {
                            Future.delayed(Duration(seconds: 1), () {
                              //navigate to the helper accept sos screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HelperSOSScreen())
                              );
                            });
                          },
                          onFinish: () {
                            //navigate to the helper sos screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HelperSOSScreen())
                              );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 16 * scaler.widthScaleFactor,
                top: 10 * scaler.widthScaleFactor,
                child: InkWell(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}