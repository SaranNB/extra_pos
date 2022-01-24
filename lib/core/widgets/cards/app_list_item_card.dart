import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemCard extends StatelessWidget {
  final String? title;
  final String? titleValue;
  final String? subTitle;
  final String? subTitleValue;
  final String? thirdTitle;
  final String? thirdValue;
  final String? description;
  final Function()? onTap;
  final bool? isMoreButtonNeeded;
  final Function()? onMoreTap;
  final double? space;
  final double? titleWidth;

  const ListItemCard(
      {Key? key,
      this.space: 12.0,
      this.title,
      this.titleValue,
      this.subTitle,
      this.subTitleValue,
      this.thirdTitle,
      this.thirdValue,
      this.description,
      this.onTap,
      this.onMoreTap,
      this.isMoreButtonNeeded: true,
      this.titleWidth: 56.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap ?? () {},
      child: LightShadowCard(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: _buildContentAndActionSeparation(),
      )),
    );
  }

  _buildContentAndActionSeparation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReadonlyText(title!, titleValue!),
                    _buildReadonlyText(subTitle!, subTitleValue!),
                    (thirdTitle != null || thirdValue != null) ? _buildReadonlyText(thirdTitle!, thirdValue!) : Container(),
                  ]),
            ),
            isMoreButtonNeeded! ? _buildMoreInfoButton() : Container()
          ],
        ),
        description != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Text(description ?? '',
                      style: TextStyle(color: Color(0xff9C9C9C), fontSize: 14))
                ],
              )
            : Container()
      ],
    );
  }

  _buildMoreInfoButton() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: this.onMoreTap!,
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 4),
        child: Text('More Info',
            style: TextStyle(
              color: Get.theme.primaryColor,
            )),
      ),
    );
  }

  _buildReadonlyText(String? title, String? value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: this.titleWidth,
            child: Text(title ?? '',
                style: TextStyle(color: Color(0xff9C9C9C), fontSize: 14)),
          ),
          SizedBox(width: this.space),
          Expanded(
              child: Text(value ?? '',
                  style: TextStyle(
                      color: Color(0xff3D404E),
                      fontSize: 14,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class LightShadowCard extends StatelessWidget {
  final Widget? child;

  const LightShadowCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: this.child,
    );
  }
}
