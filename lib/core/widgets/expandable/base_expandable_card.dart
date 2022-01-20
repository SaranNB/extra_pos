import 'package:extra_pos/core/utils/hex_color.dart';
import 'package:extra_pos/core/widgets/cards/app_search_card.dart';
import 'package:flutter/material.dart';

import 'expandable_card.dart';

class BaseExpandableCard extends StatelessWidget {
  final String? title;
  final Widget? body;
  final Widget? actionBar;
  final ExpandableCardAction? actionType;
  final Function(bool isExpanded)? onExpansionChanged;

  BaseExpandableCard(
      {@required this.title,
      this.body,
      this.actionBar,
      this.actionType, this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    return AppSearchCard(
        child: AppExpandableCard(
          onExpansionChanged: this.onExpansionChanged,
      actionType: actionType!,
      maintainState: true,
      title: Text(title!, style: TextStyle(color: Colors.black)),
      headerBackgroundColor: HexColor('#f1f2f2'),
      children: [
        Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0), child: body),
        this.actionBar!
      ],
    ));
  }
}
