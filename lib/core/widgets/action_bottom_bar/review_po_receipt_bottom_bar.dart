import 'package:extra_pos/core/widgets/action_bottom_bar/base_action_bottom_bar.dart';
import 'package:extra_pos/core/widgets/fab/action_fab.dart';
import 'package:flutter/material.dart';

class ReviewPOReceiptBottomBar extends StatelessWidget {
  final Function()? onCancelPressed;
  final Function()? onAddPressed;
  final Function()? onSubmitPressed;

  final bool isCancelEnabled;
  final bool isAddEnabled;
  final bool isSubmitEnabled;

  const ReviewPOReceiptBottomBar(
      {Key? key,
        this.onCancelPressed,
        this.onAddPressed,
        this.onSubmitPressed,
        this.isCancelEnabled: true,
        this.isAddEnabled: true,
        this.isSubmitEnabled: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseActionBottomBar(
      children: [
        CancelActionFab(
            enabled: isCancelEnabled, onPressed: this.onCancelPressed!),
        AddActionFab(enabled: isAddEnabled, onPressed: this.onAddPressed!),
        SubmitActionFab(
            enabled: isSubmitEnabled, onPressed: this.onSubmitPressed!)
      ],
    );
  }
}
