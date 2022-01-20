import 'package:extra_pos/core/widgets/base/base_app_bar.dart';
import 'package:extra_pos/core/widgets/base/base_scaffold.dart';
import 'package:extra_pos/core/widgets/expandable/search_exbandable_card.dart';
import 'package:extra_pos/core/widgets/inputs/app_dropdown_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_selectable_input_field.dart';
import 'package:extra_pos/core/widgets/inputs/app_text_input_field.dart';
import 'package:flutter/material.dart';

class ScrollTestPage extends StatelessWidget {


  const ScrollTestPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      shouldIncludeScrolling: true,
      appBar: BaseAppBar(title: 'Scroll Test'),
      body: Column(
        children: [
          _buildSearchFilerUi(),
        ],
      ),
    );
  }

  _buildSearchFilerUi() {
    return SearchExpandableCard(
      onResetPressed: () {
      },
      onSearchPressed: () {

      },
      body: Column(
        children: [
          AppTextInputField(
            title: 'TRN',
            hint: 'Search',
          ),
          AppSelectableInputField(
              title: 'Branch',
              hint: 'Search',
              suffixIcon: Icon(Icons.search),
              onTap: () {

              }),
          AppSelectableInputField(
              title: 'User',
              hint: 'Search',
              suffixIcon: Icon(Icons.search))
        ],
      ),
    );
  }
}