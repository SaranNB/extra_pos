import 'package:extra_pos/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoBottomSheet extends StatelessWidget {
  final String? title;
  final List<ReadonlyTitleValue>? list;
  final String? actionButtonTitle;
  final Function? onActionButtonPressed;
  final bool? actionButtonVisibility;

  InfoBottomSheet(
      {Key? key,
      @required this.title,
      this.list: const [],
      @required this.actionButtonTitle,
      this.onActionButtonPressed,
      this.actionButtonVisibility: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleHeader(),
          _buildInfoList(),
          this.actionButtonVisibility! ? _buildActionButton() : Container()
        ],
      ),
    );
  }

  _buildTitleHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 28.0,
                    ))),
          ],
        ),
        Divider()
      ],
    );
  }

  _buildInfoList() {
    var verticalSpacing = 8.0;
    var valueLeadingSpacing = 16.0;
    var textFontSize = 16.0;

    return Container(
      child: ListView.builder(
          itemCount: list!.length,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                        margin: EdgeInsets.only(
                            top: verticalSpacing, bottom: verticalSpacing),
                        child: Text(list![position].title ?? '',
                            style: TextStyle(
                                color: Color(0xff717171),
                                fontSize: textFontSize)))),
                Expanded(
                    flex: 7,
                    child: Container(
                        margin: EdgeInsets.only(
                            left: valueLeadingSpacing,
                            top: verticalSpacing,
                            bottom: verticalSpacing),
                        child: Text(list![position].value ?? '',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: textFontSize))))
              ],
            );
          }),
    );
  }

  _buildActionButton() {
    var bottomMargin = 16.0;
    var topMargin = 16.0;

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
            width: Get.width,
            child: PrimaryButton(
              onPressed: () {
                onActionButtonPressed!();
              },
              text: actionButtonTitle!,
            ),
          ),
        )
      ],
    );
  }
}

class ReadonlyTitleValue {
  String? title;
  String? value;

  ReadonlyTitleValue({this.title, this.value});
}
