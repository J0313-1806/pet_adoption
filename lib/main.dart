import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/bindings/bindings.dart';
import 'package:pet_adoption/source/database/database.dart';
import 'package:pet_adoption/source/view/mobile/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fintech Demo',
      darkTheme: ThemeData.dark(),
      // themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: const HomeNavigation(),
    );
  }
}
