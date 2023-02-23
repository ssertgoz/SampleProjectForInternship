import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intern_app/screens/bluetooth_connection/bluetooth_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:intern_app/screens/entry/entry_screen.dart';

import 'screens/auth/signup_screen.dart';

void showLayoutGuidelines() {
  debugPaintSizeEnabled = false;
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    showLayoutGuidelines();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EntryScreen(),
    );
  }
}
