import 'package:extra_pos/core/app_assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MenuIcon extends StatelessWidget {
  final String imagePath;
  final String? subTitle;
  final Color? iconColor;
  final Function()? onPressed;

  const MenuIcon({
    Key? key,
    required this.imagePath,
    @required this.subTitle,
    this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const menuSubTitleColor = Color(0xff6D6E71);

    return Column(
      children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          onPressed: this.onPressed,
          child: SvgPicture.asset(this.imagePath),
          backgroundColor:
              this.iconColor == null ? Get.theme.primaryColor : this.iconColor,
        ),
        SizedBox(height: 8.0),
        Text(this.subTitle!, style: TextStyle(color: menuSubTitleColor))
      ],
    );
  }
}
