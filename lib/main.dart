import 'dart:ui';

import 'package:daily_task/app/utils/services/dio_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/config/routes/app_pages.dart';
import 'app/config/themes/app_theme.dart';
import 'app/constants/app_constants.dart';
import 'app/features/bindings/auth_service_binding.dart';
import 'firebase_options.dart';

main() async {

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: TaskPlannerFirebaseOptions.currentPlatform);
  await DioInitInjection.init();
  await GetStorage.init(GetxStorageConstants.getXPref);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bug Tracker',
      theme: AppTheme.basic,
      initialBinding: AuthServiceBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      scrollBehavior: CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      unknownRoute: AppPages.routes.last,
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
