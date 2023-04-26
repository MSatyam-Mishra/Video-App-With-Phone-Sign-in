import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String location = 'Null, Press Button';
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.locality}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return

        //Text('${Address}'),
        ElevatedButton(
      onPressed: () async {
        Position position = await _getGeoLocationPosition();
        location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
        GetAddressFromLatLong(position);
      },
      child: Text('${Address}'),
    );
  }
}










// class MapActivity extends StatefulWidget {
//   @override
//   _MapActivityState createState() => _MapActivityState();
// }

// class _MapActivityState extends State<MapActivity> {
//   late LatLng _center;

//   late geo.Position currentLocation;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserLocation();
//   }

//   Future<geo.Position> locateUser() async {
//     return geo.Geolocator.getCurrentPosition(
//         desiredAccuracy: geo.LocationAccuracy.high);
//   }

//   getUserLocation() async {
//     currentLocation = await locateUser();
//     setState(() {
//       _center = LatLng(currentLocation.latitude, currentLocation.longitude);
//     });
//     print('center $_center');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class LocationPage extends StatefulWidget {
//   const LocationPage({Key? key}) : super(key: key);

//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//   LocationData? _userLocation;

//   Future<void> _getUserLocation() async {
//     Location location = Location();

//     // Check if location service is enable
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     // Check if permission is granted
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     final _locationData = await location.getLocation();
//     setState(() {
//       _userLocation = _locationData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: _getUserLocation,
//                 child: const Text('Check Location')),
//             const SizedBox(height: 25),
//             // Display latitude & longtitude
//             _userLocation != null
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Wrap(
//                       children: [
//                         Text('Your latitude: ${_userLocation?.latitude}'),
//                         const SizedBox(width: 10),
//                         Text('Your longtitude: ${_userLocation?.longitude}')
//                       ],
//                     ),
//                   )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }
