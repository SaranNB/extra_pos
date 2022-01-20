import 'package:get/get.dart';

class AppState<T> {
  var isInitial = false.obs;
  var isLoading = false.obs;
  var isCompleted = false.obs;
  var isError = false.obs;
  Rx<T> response = Rx<T>(null!);
  var message = ''.obs;
  var state = Rx<Status>(Status.INITIAL);

  AppState() {
    this.isInitial.value = true;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = false;

    state.value = Status.INITIAL;
  }

  notifyLoading() {
    this.isInitial.value = false;
    this.isLoading.value = true;
    this.isCompleted.value = false;
    this.isError.value = false;

    state.value = Status.LOADING;
  }

  notifyCompleted(T data) {
    this.response.value = data;
    this.message.value = message as String;

    this.isInitial.value = false;
    this.isLoading.value = false;
    this.isCompleted.value = true;
    this.isError.value = false;

    state.value = Status.COMPLETED;
  }

  notifyError(String message) {
    this.response.value = message as T;
    this.message.value = message;

    this.isInitial.value = false;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = true;

    state.value = Status.ERROR;
  }

}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }