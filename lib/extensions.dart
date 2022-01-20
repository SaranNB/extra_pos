

import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'core/utils/validation_message.dart';

extension RxValidationMessageExtension on Rx<ValidationMessage> {

  get message => this.value.message;

  get valid => this.value.valid;

  get invalid => this.value.invalid;

  setError(String message) {
    this.value.valid = false;
    this.value.message = message;
    this.refresh();
  }

  setValid() {
    this.value.valid = true;
    this.value.message = null;
    this.refresh();
  }
}