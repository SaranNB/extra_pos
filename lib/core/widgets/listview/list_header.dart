import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListHeader extends StatelessWidget {
  final String? title;
  final String? totalRecords;

  const ListHeader({Key? key, this.title: 'Results', this.totalRecords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(this.title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Get.theme.primaryColor)),
          ),
          Text('Total Records: '),
          Text(this.totalRecords.toString())
        ],
      ),
    );
  }
}
