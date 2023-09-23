import 'package:afro_hit/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "regular",
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0),
      ),
      home: const HomePage(),
    );
  }
}
