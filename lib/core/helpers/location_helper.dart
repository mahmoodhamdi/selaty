import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selaty/core/helpers/logger_helper.dart';

class LocationHelper {
  static Future<String?> getAddressFromCurrentLocation() async {
    try {
      // Log that location permission check is starting
      LoggerHelper.info("Checking location permissions...");

      // Check for location permissions
      var status = await Permission.location.status;
      if (!status.isGranted) {
        // Request location permission
        LoggerHelper.warning(
            "Location permission not granted. Requesting permission...");
        if (await Permission.location.request().isGranted) {
          LoggerHelper.info("Location permission granted.");
        } else {
          LoggerHelper.error("Location permission denied.");
          return Future.error('Location permissions are denied.');
        }
      }

      // Log that location services status is being checked
      LoggerHelper.info("Checking if location services are enabled...");

      // Check if location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        LoggerHelper.error("Location services are disabled.");
        return Future.error(
            'Location services are disabled. Please enable them.');
      }

      // Log that location retrieval is starting
      LoggerHelper.info("Retrieving current location...");

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
      );
      LoggerHelper.debug(
          "Current location: Latitude ${position.latitude}, Longitude ${position.longitude}");

      // Log that address retrieval from coordinates is starting
      LoggerHelper.info("Getting address from coordinates...");

      // Get the address from the position
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
        LoggerHelper.info("Address found: $address");
        return address;
      } else {
        LoggerHelper.warning("No address found for the current location.");
        return Future.error('No address found for the current location.');
      }
    } on PermissionDeniedException {
      LoggerHelper.error("Location permissions are permanently denied.");
      return Future.error('Location permissions are permanently denied.');
    } on LocationServiceDisabledException {
      LoggerHelper.error("Location services are disabled.");
      return Future.error('Location services are disabled.');
    } on PlatformException catch (e) {
      LoggerHelper.error(
          "Failed to get location due to a platform exception.", e.message);
      return Future.error('Failed to get location: ${e.message}');
    } catch (e) {
      LoggerHelper.error("An unknown error occurred.", e);
      return Future.error('An unknown error occurred: $e');
    }
  }
}
