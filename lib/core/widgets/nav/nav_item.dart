import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:extra_pos/core/app_assets/app_assets.dart';

class NavItem extends StatelessWidget {
  final String? iconPath;
  final Function()? onTap;
  final String? title;

  const NavItem(
      {Key? key, @required this.iconPath, this.onTap, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    const navMenuItemTextColor = Color(0xff768198);

    const navMenuItemTextStyle = TextStyle(
        color: navMenuItemTextColor,
        fontSize: 16.0
    );


    return GestureDetector(
      onTap: this.onTap,
      child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(this.iconPath),
              SizedBox(width: 16.0),
              Text(this.title!, style: navMenuItemTextStyle)
            ],
          )),
    );
  }
}