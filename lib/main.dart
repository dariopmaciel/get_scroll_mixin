import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';
import 'package:get_scroll_mixin/pages/user_list_page.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get Scroll Mixim - Demo',
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(
              () => Dio(BaseOptions(baseUrl: 'http://10.0.0.104:8080/')),
              fenix: true);
          Get.lazyPut(
            () => UserRepository(dio: Get.find()),
            fenix: true,
          );
        },
      ),
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const UserListPage(),
          binding: BindingsBuilder.put(() => UserListController(),)
        ),
      ],
    );
  }
}
