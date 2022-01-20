import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ActionBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

enum AppActionIconType {
  Cancel,
  Delete,
  Save,
  Add,
  Submit,
}

// class AppActionIcon extends StatelessWidget {
//   final AppActionIconType type;
//   final Function onPressed;
//   AppActionIcon({
//     Key key,
//     @required this.onPressed,
//     @required this.type,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (type == AppActionIconType.Cancel) return _cancel();
//     if (type == AppActionIconType.Delete) return _delete();
//     if (type == AppActionIconType.Save) return _save();
//     if (type == AppActionIconType.Add) return _add();
//     if (type == AppActionIconType.Submit) return _submit();
//
//     return null;
//   }
//
//   Widget _cancel() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: MaterialButton(
//             elevation: 5.0,
//             onPressed: onPressed,
//             color: Colors.white,
//             textColor: Colors.red,
//             child: Icon(
//               Icons.clear,
//               size: 24,
//             ),
//             padding: EdgeInsets.all(16),
//             shape: CircleBorder(),
//           ),
//         ),
//         Text("Cancel"),
//       ],
//     );
//   }
//
//   Widget _delete() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.red,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: MaterialButton(
//             elevation: 5.0,
//             onPressed: onPressed,
//             color: Colors.white,
//             textColor: Colors.red,
//             child: Icon(
//               Icons.delete,
//               size: 24,
//             ),
//             padding: EdgeInsets.all(16),
//             shape: CircleBorder(),
//           ),
//         ),
//         Text("Delete"),
//       ],
//     );
//   }
//
//   Widget _save() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.white,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: MaterialButton(
//             elevation: 5.0,
//             onPressed: onPressed,
//             color: Colors.blue,
//             textColor: Colors.white,
//             child: Icon(
//               Icons.save,
//               size: 24,
//             ),
//             padding: EdgeInsets.all(16),
//             shape: CircleBorder(),
//           ),
//         ),
//         Text("Save"),
//       ],
//     );
//   }
//
//   Widget _add() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blue,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: MaterialButton(
//             elevation: 5.0,
//             onPressed: onPressed,
//             color: Colors.white,
//             textColor: Colors.blue,
//             child: Icon(
//               Icons.add,
//               size: 24,
//             ),
//             padding: EdgeInsets.all(16),
//             shape: CircleBorder(),
//           ),
//         ),
//         Text("Add"),
//       ],
//     );
//   }
//
//   Widget _submit() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.white,
//             ),
//             shape: BoxShape.circle,
//           ),
//           child: MaterialButton(
//             elevation: 5.0,
//             onPressed: onPressed,
//             color: Colors.blue,
//             textColor: Colors.white,
//             child: Icon(
//               Icons.add_a_photo,
//               size: 24,
//             ),
//             padding: EdgeInsets.all(16),
//             shape: CircleBorder(),
//           ),
//         ),
//         Text("Submit"),
//       ],
//     );
//   }
// }
