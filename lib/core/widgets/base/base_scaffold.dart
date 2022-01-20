import 'package:flutter/material.dart';

import 'base_app_bar.dart';

class BaseScaffold extends StatelessWidget {
  final bool shouldIncludeScrolling;
  final bool shouldIncludePageMargin;

  final BaseAppBar? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  BaseScaffold({
    this.shouldIncludeScrolling: true,
    this.shouldIncludePageMargin: true,
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: this.appBar,
      body: _buildBodyContainer(context),
      drawer: this.drawer,
      bottomNavigationBar: this.bottomNavigationBar,
      backgroundColor: Colors.white,
    ));
  }

  _buildBodyContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: shouldIncludePageMargin
            ? EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0)
            : null,
        child: shouldIncludeScrolling
            ? SingleChildScrollView(child: this.body)
            : this.body,
      ),
    );

    _buildContainer() {}
  }
}
