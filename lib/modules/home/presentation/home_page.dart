import 'package:extra_pos/core/i18n/translation_titles.dart';
import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/utils/date_time_utils.dart';
import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/branding/app_logo.dart';
import 'package:extra_pos/core/widgets/icon_holder/menu_icon_holder.dart';
import 'package:extra_pos/core/widgets/nav/nav_item.dart';
import 'package:extra_pos/core/widgets/text/page_heading_text.dart';
import 'package:extra_pos/core/widgets/text/page_sub_heading_text.dart';
import 'package:extra_pos/modules/lookup/presentation/user_info_controller.dart';
import 'package:extra_pos/modules/po_receipts/data/crud_po_receipt_line/info_for_po_line_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  var controller = Get.find<HomeController>();
  var userInfoController = Get.find<UserInfoController>();

  @override
  Widget build(BuildContext context) {
    userInfoController.getUserInfoAndNotify();

    return BaseScaffold(
        appBar: BaseAppBar(title: '', hideDefaultLeading: false),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/images/left_nav/user_profile.svg'),
                      SizedBox(width: 16.0),
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageSubHeadingText(
                                text: userInfoController.userInfoState.response
                                        .value.firstName ??
                                    ''),
                            SizedBox(height: 4.0),
                            Text(
                                readableDateTime(userInfoController
                                    .userInfoState.response.value.lastLogin),
                                style: TextStyle(color: Color(0xff858589)))
                          ],
                        );
                      })
                    ],
                  )),
              Divider(),
              NavItem(
                  iconPath: 'assets/images/left_nav/home.svg',
                  onTap: () {},
                  title: TT.nav_title_home.tr),
              NavItem(
                  iconPath: 'assets/images/left_nav/profile.svg',
                  onTap: () {},
                  title: TT.nav_title_profile.tr),
              NavItem(
                  iconPath: 'assets/images/left_nav/settings.svg',
                  onTap: () {},
                  title: TT.nav_title_settings.tr),
              NavItem(
                  iconPath: 'assets/images/left_nav/logout.svg',
                  onTap: () {
                    controller.logout();
                  },
                  title: TT.nav_title_logout.tr)
            ],
          ),
        ),
        body: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(),
              SizedBox(height: AppDimens.logoBottomHeight),
              Obx(() {
                return PageHeadingText(
                    text:
                        '${TT.text_welcome.tr} ${userInfoController.userInfoState.response.value.firstName ?? ''}');
              }),
              SizedBox(height: AppDimens.homeMenuTopHeight),
              PageSubHeadingText(text: TT.title_menu.tr),
              SizedBox(height: AppDimens.homeMenuBottomHeight),
              HomeMenuList()
            ],
          ),
        ));
  }
}

class HomeMenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: [
          MenuIcon(
              imagePath: 'assets/images/home/requisition.svg',
              subTitle: TT.menu_title_requisition.tr,
              onPressed: () {
                Get.toNamed(Routes.requisitionHome);
              }),
          MenuIcon(
            imagePath: 'assets/images/home/receipts.svg',
            subTitle: TT.menu_title_receipts.tr,
            onPressed: () async {
              Get.toNamed(Routes.poReceiptHome);
            },
          ),
          MenuIcon(
            imagePath: 'assets/images/home/approvals.svg',
            subTitle: TT.menu_title_approvals.tr,
            onPressed: () {
              // var poReceiptInfo = InfoForPOReceiptLineCrud(
              //     poReceiptHeaderInfo: PoReceiptHeaderInfo(
              //         headerId: 186, branchId: 9));
              //
              // Get.toNamed(Routes.crudPoReceiptLineItem, arguments: poReceiptInfo.toJson());
            },
          ),
          MenuIcon(
            imagePath: 'assets/images/home/receivables.svg',
            subTitle: TT.menu_title_receivables.tr,
            onPressed: () async{
            },
          ),
          MenuIcon(
            imagePath: 'assets/images/home/csv.svg',
            subTitle: TT.menu_title_csv.tr,
            onPressed: () {},
          ),
          MenuIcon(
            imagePath: 'assets/images/home/inventory.svg',
            subTitle: TT.menu_title_inventory.tr,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
