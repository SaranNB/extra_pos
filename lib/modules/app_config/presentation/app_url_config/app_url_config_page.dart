import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/branding/app_logo.dart';
import 'package:extra_pos/core/widgets/buttons/primary_button.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:extra_pos/core/widgets/text/page_heading_text.dart';
import 'package:extra_pos/modules/app_config/presentation/app_url_config/app_url_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extra_pos/extensions.dart';

class AppUrlConfigPage extends StatelessWidget {

  var controller = Get.put(AppUrlConfigController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 48),
          AppLogo(),
          SizedBox(height: AppDimens.logoBottomHeight),
          PageHeadingText(text: TT.title_configure_app.tr),
          SizedBox(height: AppDimens.pageHeadingBottomHeight),
          Obx(() {
              return AppTextInputField(
                title: TT.title_configure_app.tr,
                hint: TT.input_hint_app_url.tr,
                // value: controller.appUrl.value,
                errorText: controller.appUrlValidation.message,
                onChanged: (value) {
                  controller.appUrl.value = value;
                },
              );
          }),
          SizedBox(height: AppDimens.formControlBottomHeight),
          SizedBox(
              width: Get.width,
              child: PrimaryButton(
                text: TT.button_text_configure.tr,
                onPressed: () {
                  controller.saveAppUrl();
                },
              ))
        ],
      ),
    );
  }
}
