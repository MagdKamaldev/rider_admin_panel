// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout with API server");
      case DioExceptionType.badCertificate:
        return ServerFailure("Bad certificate with API server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response?.statusCode ?? 500, e.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request cancelled with API server");
      case DioExceptionType.connectionError:
        return ServerFailure("No connection with API server");
      case DioExceptionType.unknown:
        return ServerFailure("Unknown error with API server");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    final message = response is Map<String, dynamic>
        ? response["message"] ?? response["msg"] ?? "Unknown server error"
        : "Unknown server error";

    switch (statusCode) {
      case 404:
        return ServerFailure("Request not found, please try again later!");
      case 500:
        return ServerFailure(
            "A problem occurred with the remote server, please try again later!");
      case 400:
      case 401:
      case 403:
      case 422:
        return ServerFailure(message);
      default:
        return ServerFailure(message);
    }
  }
}
