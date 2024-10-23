import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/selaty.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setupServiceLocator();
  runApp(DevicePreview(
      enabled: true,
      builder: (context) {
        return const Selaty();
      }));
}
