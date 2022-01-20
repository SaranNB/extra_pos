import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/branding/app_logo.dart';
import 'package:extra_pos/modules/splash/presentation/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {

  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      shouldIncludeScrolling: false,
      body: Container(
        child: Center(
          child: AppLogo(),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/branding/splash.png'),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}
