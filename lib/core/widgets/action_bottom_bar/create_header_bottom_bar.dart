import 'package:extra_pos/core/widgets/action_bottom_bar/base_action_bottom_bar.dart';
import 'package:extra_pos/core/widgets/fab/action_fab.dart';
import 'package:flutter/material.dart';

class CreateHeaderBottomBar extends StatelessWidget {
  final Function()? onCancelPressed;
  final Function()? onSaveAndContinuePressed;

  const CreateHeaderBottomBar({
    Key? key,
    this.onCancelPressed,
    this.onSaveAndContinuePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseActionBottomBar(
      children: [
        CancelActionFab(onPressed: this.onCancelPressed!),
        SaveAndContinueActionFab(onPressed: this.onSaveAndContinuePressed!)
      ],
    );
  }
}
