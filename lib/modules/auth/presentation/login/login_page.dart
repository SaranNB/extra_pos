import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:extra_pos/core/utils/app_state.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/branding/app_logo.dart';
import 'package:extra_pos/core/widgets/buttons/primary_button.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/text/app_error_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  var controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {

    controller.reset();

    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 48.0),
          AppLogo(),
          SizedBox(height: AppDimens.logoBottomHeight),
          Obx(() => TextFormField(
                onChanged: (value) {
                  controller.username.value = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Icon(Icons.person_outline),
                    ),
                    labelText: TT.input_hint_username.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    errorText: controller.usernameValidation.invalid
                        ? controller.usernameValidation.message
                        : null),
              )),
          SizedBox(height: 8.0),
          Obx(() {
            return TextFormField(
              //initialValue: 'Nandha@234',
              onChanged: (value) => controller.password.value = value,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 0),
                    // add padding to adjust icon
                    child: Icon(Icons.lock_outline),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off, color: Color(0xff646464),),
                    onPressed: () {
                      controller.changePasswordVisibility();
                    },
                  ),
                  labelText: TT.input_hint_password.tr,
                  labelStyle: TextStyle(color: Colors.grey),
                  errorText: controller.passwordValidation.invalid
                      ? controller.passwordValidation.message
                      : null),
            );
          }),
          SizedBox(height: AppDimens.formControlEndHeight),
          SizedBox(
              width: Get.width,
              child: PrimaryButton(
                text: TT.button_text_login.tr,
                onPressed: () async{
                  controller.login();
                },
              )),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(() {
              return controller.loginState.isError.value
                  ? AppErrorText(text: controller.loginState.message.value)
                  : Container();
            }),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(TT.text_forgot_password.tr)
        ],
      ),
    );
  }
}
