import 'dart:async';
import 'package:dio/dio.dart';
import 'package:extra_pos/core/exceptions/network_exception.dart';
import 'package:extra_pos/core/services/error_response.dart';
import 'package:extra_pos/core/stores/app_config_store.dart';
import 'package:extra_pos/core/stores/auth_store.dart';
import 'package:extra_pos/core/utils/urls.dart';
import 'package:extra_pos/core/widgets/dialogs/action_alert_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/circular_progress_loader_dialog.dart';
import 'package:extra_pos/core/widgets/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Getx;
import 'package:meta/meta.dart';

abstract class BaseApiClient {
  Future<dynamic> get(String url,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      bool removeNulls});

  Future<dynamic> post(String url,
      {Map<String, dynamic> headers, @required body});

  Future<dynamic> put(String url,
      {Map<String, dynamic> headers, @required body});
}

class BaseApiClientImpl implements BaseApiClient {
  final Dio _dio;

  bool retriedByUser = false;

  BaseApiClientImpl(this._dio) {
    _initApiClient();
  }

  void _initApiClient() {
    setBaseUrl();
    _dio.options.connectTimeout = 15000;
    _dio.options.receiveTimeout = 15000;
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (RequestOptions options) async {
    //       if (!options.headers.containsKey("Authorization") &&
    //           AuthStore.to.accessToken != null) {
    //         options.headers["Authorization"] =
    //             "Bearer ${AuthStore.to.accessToken}";
    //       }
    //       return options;
    //     },
    //     onResponse: (Response response) async {
    //       return response;
    //     },
    //     onError: (DioError e) async {
    //       var networkException = NetworkException.getDioException(e);
    //       if (networkException is RequestTimeoutException ||
    //           networkException is NoInternetConnectionException ||
    //           networkException is DefaultErrorException) {
    //         if (retriedByUser) {
    //           Getx.Get.back();
    //         }
    //         var selection = await showDialog<bool>(
    //             context: Getx.Get.context!,
    //             builder: (BuildContext context) {
    //               return ActionAlertDialog(
    //                 title: 'Alert',
    //                 message: 'Unable to connect to Network',
    //                 negativeActionText: 'Reset App',
    //                 positiveActionText: 'Retry',
    //                 onNegativeActionTapped: () {
    //                   print('Negative Action');
    //                   Getx.Get.back(result: false);
    //                 },
    //                 onPositiveActionTapped: () {
    //                   print('Positive Action');
    //                   Getx.Get.back(result: true);
    //                 },
    //               );
    //             },
    //             barrierDismissible: false);
    //
    //         if (selection!) {
    //           CircularProgressLoaderDialog.showLoader(
    //               Getx.Get.context!, 'Retrying, please wait...');
    //           return _retry(e.request, true);
    //         } else {
    //           AppConfigStore.to.saveAppUrl(null);
    //           AuthStore.to.logoutAndGotoConfig();
    //           return e;
    //         }
    //
    //         // Get.to(DialogTestPage());
    //       }
    //
    //       if (e.response == null) return e;
    //
    //       if (e.response.statusCode != 401) return e;
    //
    //       if (e.response.statusCode == 401 &&
    //           e.request.path == 'authenticate') {
    //         return e;
    //       }
    //
    //       var isAccessTokenExpired = AuthStore.to.isAccessTokenExpired();
    //       var isRefreshTokenExpired = AuthStore.to.isRefreshTokenExpired();
    //
    //       if (e.response.statusCode == 401 && isRefreshTokenExpired) {
    //         AuthStore.to.logout();
    //         return e;
    //       } else if (e.response.statusCode == 401 && isAccessTokenExpired) {
    //         await renewAccessToken();
    //         return _retry(e.request, false);
    //       }
    //
    //       return e;
    //     },
    //   ),
    // );
  }

  Future<void> renewAccessToken() async {
    setBaseUrl();
    final refreshToken = AuthStore.to.refreshToken;
    final accessToken = AuthStore.to.accessToken;

    try {
      var dio = Dio();
      dio..options.baseUrl = _getConfiguredBaseUrl();
      var headers = {'Authorization': 'Bearer $refreshToken'};
      final request = dio.post(URLs.refresh,
          data: {'accessToken': accessToken},
          options: Options(headers: headers));
      final response = await request;

      if (response.statusCode == 200) {
        var newAccessToken = response.data['token'];
        await AuthStore.to.saveAccessTokenAsync(newAccessToken);
      }
    } catch (e) {
      // Logout
    }
  }

  Future<Response<dynamic>> _retry(
      RequestOptions requestOptions, bool retriedByUser) async {
    this.retriedByUser = retriedByUser;
    setBaseUrl();
    requestOptions.headers["Authorization"] =
        "Bearer ${AuthStore.to.accessToken}";
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return this._dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  @override
  Future<dynamic> get(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool removeNulls: false}) async {
    try {
      setBaseUrl();
      if (removeNulls)
        queryParameters!
            .removeWhere((key, value) => key == null || value == null);
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      await handleError(e as DioError);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? headers,
    @required body,
    bool authorization = false,
  }) async {
    try {
      setBaseUrl();
      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      await handleError(e as DioError);
    }
  }

  @override
  Future put(
    String url, {
    Map<String, dynamic>? headers,
    @required body,
  }) async {
    try {
      setBaseUrl();
      final response =
          await _dio.put(url, data: body, options: Options(headers: headers));

      return response.data;
    } catch (e) {
      await handleError(e as DioError);
    }
  }

  setBaseUrl() {
    var baseUrl = _getConfiguredBaseUrl();
    this._dio..options.baseUrl = baseUrl; // AppConfigStore.to.appUrl;//
  }

  _getConfiguredBaseUrl() {
    var configuredBaseUrl = AppConfigStore.to.appUrl;
    if (configuredBaseUrl == null) {
      return '';
    }

    var urlLastChar = configuredBaseUrl.substring(configuredBaseUrl.length - 1);

    if (urlLastChar != '/') {
      configuredBaseUrl = configuredBaseUrl + '/';
    }

    return configuredBaseUrl;
  }

  Future handleError(DioError e) async {
    if (e.response?.data['error'] == true ||
        e.response?.data['error'] == 'true') {
      if (e.response?.data['message'] != null) {
        throw NetworkException.customServerException(
            e.response?.data['message']);
      }
      if (e.response?.data['errorMesage'] != null) {
        var errorResponse = ErrorResponse.fromJson(e.response?.data);
        List<String?>? otherMessages =
            errorResponse.errorDetails?.map((e) => e.errorDescription).toList();
        await showMessageDialog(
            type: MessageDialogType.ERROR,
            mainMessage: errorResponse.errorMesage,
            otherMessages: otherMessages,
            closeAfterDelay: false);
        throw NetworkException.customServerException(errorResponse.errorMesage ?? '');
      }
    }

    throw NetworkException.getDioException(e);
  }
}
