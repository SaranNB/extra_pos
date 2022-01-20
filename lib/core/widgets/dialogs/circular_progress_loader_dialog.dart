import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularProgressLoaderDialog {
  static showLoader(BuildContext context, String message) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              titlePadding: EdgeInsets.all(8),
              contentPadding: EdgeInsets.all(8),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Get.theme.primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(message),
                    ),
                  )
                ],
              ),
              // actions: actions, // ?? <Widget>[cancelButton, confirmButton],
              buttonPadding: EdgeInsets.zero,
            ));
  }
}
