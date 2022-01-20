import 'package:extra_pos/core/widgets/action_bottom_bar/base_action_bottom_bar.dart';
import 'package:extra_pos/core/widgets/fab/action_fab.dart';
import 'package:flutter/material.dart';

class CreateOrEditBottomBar extends StatelessWidget {
  final Function()? onCancelPressed;
  final Function()? onDeletePressed;
  final Function()? onSavePressed;
  final Function()? onAddPressed;

  const CreateOrEditBottomBar(
      {Key? key,
      this.onCancelPressed,
      this.onDeletePressed,
      this.onSavePressed,
      this.onAddPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseActionBottomBar(
      children: [
        CancelActionFab(onPressed: this.onCancelPressed!),
        DeleteActionFab(onPressed: this.onDeletePressed!),
        SaveActionFab(onPressed: this.onSavePressed!),
        AddActionFab(onPressed: this.onAddPressed!)
      ],
    );
  }
}
