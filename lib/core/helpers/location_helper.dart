import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/helpers/logger_helper.dart';

class LocationHelper {
  static Future<bool> showPermissionDialog(BuildContext context) async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Location Permission',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                title: const Row(
                  children: [
                    Icon(Icons.location_on, color: primaryBlue, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'يحتاج التطبيق إلى إذن الموقع',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'يحتاج التطبيق إلى الوصول إلى موقعك لتوفير خدمة أفضل وتحديد عنوان التسليم الخاص بك',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryPurple,
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'لا',
                            style: TextStyle(
                              color: accentRedText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'نعم',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ),
                    ],
                  ),
                ],
                actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
            );
          },
        ) ??
        false;
  }

  static Future<bool> showLocationServiceDialog(BuildContext context) async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Location Services',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              )),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                title: const Row(
                  children: [
                    Icon(Icons.location_off, color: secondaryOrange, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'خدمة الموقع معطلة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: secondaryOrange,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'يرجى تفعيل خدمة الموقع في إعدادات جهازك للمتابعة',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: secondaryOrange,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_suggest,
                        size: 48,
                        color: secondaryOrange,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(
                              color: accentRedText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'فتح الإعدادات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await Geolocator.openLocationSettings();
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
            );
          },
        ) ??
        false;
  }

  static LocationSettings getPlatformSpecificSettings() {
    if (Platform.isAndroid) {
      LoggerHelper.info("Using Android-specific location settings");
      return AndroidSettings(
        accuracy: LocationAccuracy.best,
      );
    } else if (Platform.isIOS) {
      LoggerHelper.info("Using iOS-specific location settings");
      return AppleSettings(
        accuracy: LocationAccuracy.best,
      );
    } else {
      LoggerHelper.info("Using default location settings");
      return const LocationSettings(
        accuracy: LocationAccuracy.best,
      );
    }
  }

  static Future<String?> getAddressFromCurrentLocation(
      BuildContext context) async {
    try {
      LoggerHelper.info("بدء التحقق من أذونات الموقع...");

      var status = await Permission.location.status;
      if (!status.isGranted) {
        LoggerHelper.warning("لم يتم منح إذن الموقع. جارٍ طلب الإذن...");

        bool shouldRequestPermission = await showPermissionDialog(context);

        if (shouldRequestPermission) {
          status = await Permission.location.request();
          if (!status.isGranted) {
            LoggerHelper.error("تم رفض إذن الموقع.");

            if (status.isPermanentlyDenied) {
              bool shouldOpenSettings = await showGeneralDialog<bool>(
                    context: context,
                    barrierDismissible: false,
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ScaleTransition(
                        scale: animation,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Row(
                            children: [
                              Icon(Icons.location_disabled,
                                  color: primaryRed, size: 28),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'إذن الموقع مطلوب',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'لقد قمت برفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات التطبيق للمتابعة.',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: secondaryPurple,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.security_update_warning,
                                  size: 48,
                                  color: primaryRed,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    child: const Text(
                                      'إلغاء',
                                      style: TextStyle(
                                        color: accentRedText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.settings,
                                            color: Colors.white, size: 18),
                                        SizedBox(width: 8),
                                        Text(
                                          'فتح الإعدادات',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      openAppSettings();
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          actionsPadding:
                              const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        ),
                      );
                    },
                  ) ??
                  false;

              if (shouldOpenSettings) {
                return null;
              }
            }
            return null;
          }
        } else {
          return null;
        }
      }

      LoggerHelper.info("التحقق من تفعيل خدمات الموقع...");

      if (!await Geolocator.isLocationServiceEnabled()) {
        LoggerHelper.error("خدمات الموقع معطلة.");
        bool shouldOpenSettings = await showLocationServiceDialog(context);
        if (!shouldOpenSettings ||
            !await Geolocator.isLocationServiceEnabled()) {
          return null;
        }
      }

      LoggerHelper.info("جارٍ تحديد الموقع الحالي...");

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: primaryBlue,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'جارٍ تحديد موقعك...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: secondaryPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      );

      try {
        // Get platform-specific location settings
        final locationSettings = getPlatformSpecificSettings();

        // Get current position with platform-specific settings
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );

        // Close loading dialog
        Navigator.of(context).pop();

        LoggerHelper.debug(
            "تم تحديد الموقع: خط العرض ${position.latitude}, خط الطول ${position.longitude}");

        LoggerHelper.info("جارٍ تحويل الإحداثيات إلى عنوان...");

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          // Create a more detailed address string
          List<String?> addressComponents = [
            place.street,
            place.subLocality,
            place.locality,
            place.administrativeArea,
            place.country,
          ]
              .where((component) => component != null && component.isNotEmpty)
              .toList();

          String address = addressComponents
              .join(', ')
              .replaceAll(RegExp(r',\s*,'), ',')
              .replaceAll(RegExp(r'^\s*,\s*|\s*,\s*$'), '');

          // Show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: primaryGreen,
              content: const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'تم تحديد موقعك بنجاح',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 3),
            ),
          );

          LoggerHelper.info("تم العثور على العنوان: $address");
          return address;
        }

        return null;
      } catch (e) {
        // Close loading dialog if it's still showing
        if (context.mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }

        // Show error snackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: primaryRed,
              content: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'حدث خطأ أثناء تحديد الموقع. يرجى المحاولة مرة أخرى.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }

        LoggerHelper.error("حدث خطأ غير متوقع", e);
        return null;
      }
    } on PlatformException catch (e) {
      LoggerHelper.error("حدث خطأ في النظام", e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: primaryRed,
          content: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'حدث خطأ في النظام. يرجى المحاولة مرة أخرى.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
        ),
      );
      return null;
    }
  }
}
