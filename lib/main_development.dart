import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:selaty/firebase_options.dart';
import 'package:selaty/selaty.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Selaty());
}
