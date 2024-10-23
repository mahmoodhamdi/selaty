import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  static Future<String?> getAddressFromCurrentLocation() async {
    // Check for location permissions
    var status = await Permission.location.status;
    if (!status.isGranted) {
      if (await Permission.location.request().isGranted) {
        // Permission granted
      } else {
        return Future.error('Location permissions are denied.');
      }
    }

    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Future.error('Location services are disabled.');
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
       );

    // Get the address from the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
    }
    return null;
  }
}
