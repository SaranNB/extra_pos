import 'package:extra_pos/core/widgets/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

class ReadonlyText extends StatelessWidget {
  final bool? isMultiline;
  final String? title;
  final String? content;

  const ReadonlyText({Key? key, this.isMultiline: true, @required this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (isMultiline!) {
      return AppSpacing(child: this._multiLine());
    }

    return AppSpacing(child: this._singleLine());
  }

  Widget _singleLine() {
    return Row(
      children: [
        Text(title!, style: TextStyle(color: Color(0xff9C9C9C), fontSize: 16)),
        Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(content!,
                style: TextStyle(color: Color(0xff3D404E), fontSize: 16)))
      ],
    );
  }

  Widget _multiLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: TextStyle(color: Color(0xff9C9C9C), fontSize: 16,)),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(content ?? '',
              style: TextStyle(color: Color(0xff3D404E), fontSize: 16,)),
        )
      ],
    );
  }
}
