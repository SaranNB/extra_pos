import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool hideDefaultLeading;

  @override
  final Size preferredSize;

  BaseAppBar({Key? key, this.title, this.actions, this.hideDefaultLeading = true})
      : preferredSize = Size.fromHeight(AppBar().preferredSize.height),
        super(key: key);

  // @override
  // Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  // @override
  // Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    const Color appbarLeadingIconColor = Color(0xff717171);

    return AppBar(
      actions: this.actions,
      iconTheme: IconThemeData(color: appbarLeadingIconColor),
      automaticallyImplyLeading: !this.hideDefaultLeading,
      title: this.hideDefaultLeading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon:
                      Icon(Icons.arrow_back_ios, color: appbarLeadingIconColor),
                ),
                Text(this.title!,
                    style: TextStyle(
                        color: Get.theme.primaryColor, fontSize: 18.0)),
                // Your widgets here
              ],
            )
          : Text(this.title!, style: TextStyle(color: Get.theme.primaryColor)),
      centerTitle: false,
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
    );
  }
}

//

// Text(this.title, style: TextStyle(color: Get.theme.primaryColor)),
