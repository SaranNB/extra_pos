import 'package:extra_pos/core/widgets/action_bottom_bar/base_action_bottom_bar.dart';
import 'package:extra_pos/core/widgets/fab/action_fab.dart';
import 'package:flutter/material.dart';

class ReviewRequisitionBottomBar extends StatelessWidget {
  final Function()? onCancelPressed;
  final Function()? onDeletePressed;
  final Function()? onAddPressed;
  final Function()? onSubmitPressed;

  final bool isCancelEnabled;
  final bool isDeleteEnabled;
  final bool isAddEnabled;
  final bool isSubmitEnabled;

  const ReviewRequisitionBottomBar(
      {Key? key,
      this.onCancelPressed,
      this.onDeletePressed,
      this.onAddPressed,
      this.onSubmitPressed,
      this.isCancelEnabled: true,
      this.isDeleteEnabled: true,
      this.isAddEnabled: true,
      this.isSubmitEnabled: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseActionBottomBar(
      children: [
        CancelActionFab(
            enabled: isCancelEnabled, onPressed: this.onCancelPressed!),
        DeleteActionFab(
            enabled: isDeleteEnabled, onPressed: this.onDeletePressed!),
        AddActionFab(enabled: isAddEnabled, onPressed: this.onAddPressed!),
        SubmitActionFab(
            enabled: isSubmitEnabled, onPressed: this.onSubmitPressed!)
      ],
    );
  }
}
