import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/icon_holder/menu_icon_holder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequisitionHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: TT.appbar_title_requisition_home.tr),
      body: Column(
        children: [
          SizedBox(height: 24),
          SizedBox(
            height: 250.0,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                MenuIcon(
                    imagePath: 'assets/images/common/list.svg',
                    subTitle: TT.menu_list.tr,
                    iconColor: AppColors.secondaryMenuIconColor,
                    onPressed: () {
                      Get.toNamed(Routes.listRequisition);
                    }),
                MenuIcon(
                  imagePath: 'assets/images/common/create.svg',
                  subTitle: TT.menu_create.tr,
                  iconColor: AppColors.secondaryMenuIconColor,
                  onPressed: () {
                    Get.toNamed(Routes.createRequisition);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
