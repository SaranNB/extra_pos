import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/widgets/action_bottom_bar/create_header_bottom_bar.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/text/app_error_text.dart';
import 'package:extra_pos/core/widgets/text/readonly_text.dart';
import 'package:extra_pos/modules/requisition/presentation/create_requisition/create_requisition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRequisitionPage extends StatelessWidget {
  var controller = Get.find<CreateRequisitionController>();

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      bottomNavigationBar: CreateHeaderBottomBar(
        onCancelPressed: () {
          Get.back();
        },
        onSaveAndContinuePressed: () {
          controller.createRequisition();
        },
      ),
      appBar: BaseAppBar(title: TT.appbar_title_create_requisition.tr, actions: [
        Row(
          children: [
            Text('More info'),
            Obx(() {
              return Switch(
                  value: controller.isMoreInfoSwitchOn.value,
                  onChanged: (value) {
                    controller.setMoreInfoSwitchState(value);
                  });
            })
          ],
        )
      ]),
      body: Column(
        children: [
          ReadonlyText(
              isMultiline: false,
              title: TT.readonly_text_trn_title.tr,
              content: 'N/A'),
          _buildMoreInfoUi(),
          ReadonlyText(isMultiline: false, title: 'Status', content: 'New'),
          Obx(() {
              if(controller.createRequisitionState.isError.value) {
                return AppErrorText(text: controller.createRequisitionState.message.value);
              } else {
                return Container();
              }
          })

        ],
      ),
    );
  }

  _buildMoreInfoUi() {
    return Container(
        child: Obx(() => controller.isMoreInfoSwitchOn.value
            ? Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ReadonlyText(
                        isMultiline: true,
                        title: 'Branch',
                        content: controller.branchInfoController.branchInfoState
                                .response.value.data?.first.branchCode ??
                            '',
                      )),
                  Expanded(
                      flex: 1,
                      child: ReadonlyText(
                        isMultiline: true,
                        title: 'User',
                        content: controller.userInfoController.userInfoState
                                .response.value.firstName,
                      ))
                ],
              )
            : SizedBox()));
  }
}
