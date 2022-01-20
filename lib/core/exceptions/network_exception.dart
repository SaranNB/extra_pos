import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extra_pos/core/services/error_response.dart';

abstract class NetworkException implements Exception {
  factory NetworkException.requestCancelled() => RequestCancelledException();

  factory NetworkException.unauthorizedRequest() =>
      UnauthorizedRequestException();

  factory NetworkException.badRequest() => BadRequestException();

  factory NetworkException.notFound(String reason) => NotFoundException();

  factory NetworkException.methodNotAllowed() => MethodNotAllowedException();

  factory NetworkException.notAcceptable() => NotAcceptableException();

  factory NetworkException.requestTimeout() => RequestTimeoutException();

  factory NetworkException.sendTimeout() => SendTimeoutException();

  factory NetworkException.conflict() => ConflictException();

  factory NetworkException.internalServerError() =>
      InternalServerErrorException();

  factory NetworkException.notImplemented() => NotImplementedException();

  factory NetworkException.serviceUnavailable() =>
      ServiceUnavailableException();

  factory NetworkException.noInternetConnection() =>
      NoInternetConnectionException();

  factory NetworkException.formatException() => FormatExceptionException();

  factory NetworkException.unableToProcess() => UnableToProcessException();

  factory NetworkException.defaultError(String error) =>
      DefaultErrorException(error);

  factory NetworkException.unexpectedError() => UnexpectedErrorException();

  // Error message from the response body
  factory NetworkException.customServerException(String message) => CustomServerException(message);
  factory NetworkException.serverDefinedException(ErrorResponse errorResponse) => ServerDefinedException(errorResponse);

  String getErrorMessage();

  ErrorResponse getErrorResponse();

  static NetworkException handleResponse(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkException.unauthorizedRequest();
        break;
      case 404:
        return NetworkException.notFound("Not found");
      case 405:
        return NetworkException.methodNotAllowed();
        break;
      case 409:
        return NetworkException.conflict();
        break;
      case 408:
        return NetworkException.requestTimeout();
        break;
      case 500:
        return NetworkException.internalServerError();
        break;
      case 503:
        return NetworkException.serviceUnavailable();
        break;
      default:
        var responseCode = statusCode;
        return NetworkException.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkException getDioException(error) {
    if (error is Exception) {
      try {
        NetworkException networkExceptions = NetworkException.defaultError('Unknown error, please contact administrator');
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.CANCEL:
              networkExceptions = NetworkException.requestCancelled();
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              networkExceptions = NetworkException.requestTimeout();
              break;
            case DioErrorType.DEFAULT:
              networkExceptions = NetworkException.noInternetConnection();
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              networkExceptions = NetworkException.sendTimeout();
              break;
            case DioErrorType.RESPONSE:
              networkExceptions =
                  NetworkException.handleResponse(error.response.statusCode);
              break;
            case DioErrorType.SEND_TIMEOUT:
              networkExceptions = NetworkException.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkException.noInternetConnection();
        } else {
          networkExceptions = NetworkException.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (e) {
        // Helper.printError(e.toString());
        return NetworkException.formatException();
      } catch (_) {
        return NetworkException.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkException.unableToProcess();
      } else {
        return NetworkException.unexpectedError();
      }
    }
  }
}

class RequestCancelledException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Request cancelled';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Request cancelled"
    );
  }
}

class UnauthorizedRequestException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Unauthorized request';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
      errorMesage: "Unauthorized request"
    );
  }
}

class BadRequestException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Bad request';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Bad request"
    );
  }
}

class NotFoundException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Request cancelled';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class MethodNotAllowedException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Method not allowed';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class NotAcceptableException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Not acceptable';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class RequestTimeoutException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Request timeout';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class SendTimeoutException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Send timeout';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class ConflictException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Error due to a conflict';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class InternalServerErrorException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Internal server error';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: ""
    );
  }
}

class NotImplementedException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Not implemented';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Not implemented"
    );
  }
}

class ServiceUnavailableException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Server is not available';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Server is not available"
    );
  }
}

class NoInternetConnectionException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'No internet connection';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "No internet connection"
    );
  }
}

class FormatExceptionException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Unexpected error occurred';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Unexpected error occurred"
    );
  }
}

class UnableToProcessException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Unable to process the data';
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Unable to process the data"
    );
  }
}

class DefaultErrorException implements NetworkException {
  final String message;

  DefaultErrorException(this.message);

  @override
  String getErrorMessage() {
    return message;
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: message
    );
  }
}

class UnexpectedErrorException implements NetworkException {
  @override
  String getErrorMessage() {
    return 'Unexpected error occurred';
  }
  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: "Unexpected error occurred"
    );
  }
}

class CustomServerException implements NetworkException {
  final String message;

  CustomServerException(this.message);

  @override
  String getErrorMessage() {
    return message;
  }

  @override
  ErrorResponse getErrorResponse() {
    return ErrorResponse(
        errorMesage: message
    );
  }
}

class ServerDefinedException implements NetworkException {
  final ErrorResponse errorResponse;

  ServerDefinedException(this.errorResponse);

  @override
  String getErrorMessage() {
    return 'Error';
  }

  @override
  ErrorResponse getErrorResponse() {
    return errorResponse;
  }
}
