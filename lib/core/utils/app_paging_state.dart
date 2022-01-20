import 'package:get/get.dart';

class AppPagingState<T> {
  var isInitial = false.obs;
  var isLoading = false.obs;
  var isCompleted = false.obs;
  var isError = false.obs;
  RxList<T> response = RxList<T>();
  var errorMessage = null.obs;
  var status = Rx<PagingStatus>(PagingStatus.INITIAL);

  var currentPage = 0.obs;
  var totalRecords = 0.obs;

  AppPagingState() {
    this.response = RxList<T>();

    this.isInitial.value = true;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = false;

    status.value = PagingStatus.INITIAL;
  }

  notifyInitial() {
    this.response = RxList<T>();

    this.isInitial.value = true;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = false;

    status.value = PagingStatus.INITIAL;
    this.totalRecords.value = 0;
  }

  notifyReset() {
    // Setting to initial state
    this.response = RxList<T>();

    this.isInitial.value = true;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = false;

    status.value = PagingStatus.INITIAL;
    this.totalRecords.value = 0;

    // Setting to loading state
    this.isInitial.value = false;
    this.isLoading.value = true;
    this.isCompleted.value = false;
    this.isError.value = false;

    status.value = PagingStatus.LOADING;
  }

  notifyLoading() {
    this.isInitial.value = false;
    this.isLoading.value = true;
    this.isCompleted.value = false;
    this.isError.value = false;

    status.value = PagingStatus.LOADING;
  }

  addItems(List<T> data, int start, int limit, int pageSize, int totalRecordSize) {
    this.response.addAll(data);
    this.errorMessage.value = null;

    this.isInitial.value = false;
    this.isLoading.value = false;
    this.isCompleted.value = true;
    this.isError.value = false;

    status.value = PagingStatus.COMPLETED;
    this.currentPage.value = (start ~/ limit) + 1;
    this.totalRecords.value = totalRecordSize;
  }

  notifyError(String message) {
    this.errorMessage.value = null;

    this.isInitial.value = false;
    this.isLoading.value = false;
    this.isCompleted.value = false;
    this.isError.value = true;

    status.value = PagingStatus.ERROR;
  }

}

enum PagingStatus { INITIAL, LOADING, COMPLETED, ERROR }