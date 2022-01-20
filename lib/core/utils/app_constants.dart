
import 'package:flutter/services.dart';

class AppConstants {
  static const isMoreInfoSwitchOn = true;
  static var quantityInputRegex = FilteringTextInputFormatter.allow(RegExp(r'^[\d\.]{0,12}([\.]\d{0,8})?'));

}