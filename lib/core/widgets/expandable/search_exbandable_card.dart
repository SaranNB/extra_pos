import 'package:extra_pos/core/utils/debounce.dart';
import 'package:extra_pos/core/widgets/expandable/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_expandable_card.dart';

class SearchExpandableCard extends StatefulWidget {
  final Widget? body;
  final Function()? onResetPressed;
  final Function()? onSearchPressed;
  ExpandableCardAction? actionType;

  SearchExpandableCard(
      {Key? key, this.body, this.onResetPressed, this.onSearchPressed})
      : super(key: key);

  @override
  _SearchExpandableCardState createState() => _SearchExpandableCardState();
}

class _SearchExpandableCardState extends State<SearchExpandableCard> {
  @override
  Widget build(BuildContext context) {
    return BaseExpandableCard(
        title: 'Search',
        body: this.widget.body,
        onExpansionChanged: (value) {
        },
        actionType: widget.actionType,
        actionBar: Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                widget.onResetPressed!();
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                      child: Text('Reset',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  widget.actionType = ExpandableCardAction.COLLAPSE;
                });
                widget.onSearchPressed!();
                FocusScope.of(context).requestFocus(FocusNode());
                Debouncer(milliseconds: 50).run(() {
                  setState(() {
                    widget.actionType = null;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Get.theme.primaryColor)),
                child: Container(
                  color: Get.theme.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                      child: Text('Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ))
          ],
        ));
  }
}
