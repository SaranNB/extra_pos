import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? negativeActionText;
  final String? positiveActionText;
  final Function()? onNegativeActionTapped;
  final Function()? onPositiveActionTapped;

  const ActionAlertDialog(
      {Key? key,
      this.title: 'Alert',
      this.message,
      this.negativeActionText: 'No',
      this.positiveActionText: 'Yes',
      required this.onNegativeActionTapped,
      required this.onPositiveActionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          Center(
              child: Text(title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(message!, style: TextStyle(color: Colors.blueGrey))),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: onNegativeActionTapped,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                        child: Text(this.negativeActionText!,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: onPositiveActionTapped,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.primaryColor)),
                  child: Container(
                    color: Get.theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                        child: Text(positiveActionText!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}

Future<bool> showAlertDialog(
    {@required String? title,
    @required String? message,
    String? negativeActionText: 'No',
    String? positiveActionText: 'Yes',
    Function()? onNegativeActionTapped,
    Function()? onPositiveActionTapped,
    bool barrierDismissible: true}) async {
  await showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return ActionAlertDialog(
          title: title,
          message: message,
          negativeActionText: negativeActionText,
          positiveActionText: positiveActionText,
          // onNegativeActionTapped: onNegativeActionTapped,
          onNegativeActionTapped: () {
            return false;
          },
          // onPositiveActionTapped: onPositiveActionTapped,
          onPositiveActionTapped: () {
            return true;
          },
        );
      },
      barrierDismissible: barrierDismissible);

  return false;
}
