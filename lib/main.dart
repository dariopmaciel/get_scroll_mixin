import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get Scroll Mixim - Demo',
      theme: ThemeData(
        
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: HomePage())
      ],
    );
  }
}
