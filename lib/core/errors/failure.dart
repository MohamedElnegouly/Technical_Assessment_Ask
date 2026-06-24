import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerError extends Failure {
  ServerError(super.errMessage);

  factory ServerError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerError("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ServerError("Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ServerError("Receive timeout with API server");
      case DioExceptionType.badCertificate:
        return ServerError("Bad certificate connection");
      case DioExceptionType.badResponse:
        final response = dioError.response;
        return ServerError.fromResponse(
          response?.statusCode ?? 0,
          response?.data,
        );
      case DioExceptionType.cancel:
        return ServerError("Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return ServerError("No internet connection");
      case DioExceptionType.unknown:
      default:
        return ServerError("Unexpected error, please try again");
    }
  }

  factory ServerError.fromResponse(int statusCode, dynamic response) {
    // تأكد إن response فعلاً Map
    if (response is! Map<String, dynamic>) {
      return ServerError("حدث خطأ غير متوقع من السيرفر");
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerError(_extractErrorMessage(response));
    } else if (statusCode == 404) {
      return ServerError('Your request was not found, please try later!');
    } else if (statusCode == 500) {
      return ServerError('Internal server error, please try later!');
    } else {
      return ServerError('Oops, there was an error, please try again');
    }
  }

  static String _extractErrorMessage(Map<String, dynamic>? response) {
  if (response == null) return 'someThing went wrong please try again';
  if (response['message'] != null) return response['message'].toString();
  if (response['error'] is Map && response['error']['message'] != null) {
    return response['error']['message'].toString();
  }
  if (response['errors'] is List && response['errors'].isNotEmpty) {
    return response['errors'][0].toString();
  }
  return 'someThing went wrong please try again';
}

}
