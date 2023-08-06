import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../injections/injections.dart';
import '../app/main_app.dart';
import '../shared_libraries/utils/setup/app_setup.dart';

void main() async {
  Config.appFlavor = Flavor.prod;
  WidgetsFlutterBinding.ensureInitialized();
  await Injections().initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
