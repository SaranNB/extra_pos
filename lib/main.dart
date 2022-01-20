import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/app_assets/app_colors.dart';
import 'core/i18n/localization_service.dart';
import 'core/routing/app_route.dart';
import 'core/routing/binding/initial_binding.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      changeStatusBarForegroundColor(AppColors.isStatusBarForegroundWhite);
    }
    super.didChangeAppLifecycleState(state);
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  changeStatusBarForegroundColor(bool isWhite) {
    if (isWhite) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(AppColors.statusBarColor);
    changeStatusBarForegroundColor(AppColors.isStatusBarForegroundWhite);

    return GetMaterialApp(
        smartManagement: SmartManagement.full,
        initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        title: 'Extra POS',
        initialRoute: Routes.initial,
        getPages: AppPages.pages,
        defaultTransition: Transition.native,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
