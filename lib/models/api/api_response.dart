import 'package:get/get.dart';
import 'error_model.dart';
import 'pagination_data.dart';
import 'resource.dart';

class ApiResponse {
  bool? success;
  Map? data;
  String? message;
  int? errorCode;
  String? metadata;
  String? validationErrors;
  String? correlationId;
  DateTime? timestamp;

  ApiResponse({
    this.success,
    this.data,
    this.message,
    this.errorCode,
    this.metadata,
    this.validationErrors,
    this.correlationId,
    this.timestamp,
  });

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      success: map['success'],
      data: map['data'] is Map ? map['data'] : null,
      message: map['message'],
      errorCode: map['errorCode'] is int ? map['errorCode'] : null,
      metadata: map['metaData'],
      validationErrors: map['validationErrors'],
      correlationId: map['correlationId'],
      timestamp:
          map['timestamp'] != null ? DateTime.parse(map['timestamp']) : null,
    );
  }

  /// Getters & Setters ********************************************************
  bool get isSucceeded => success != null && success! && errorCode == null;

  bool get isUnAuthenticated =>
      success != null && !success! && errorCode != null && errorCode == 401;

  bool get isServerError =>
      success != null && !success! && errorCode != null && errorCode! >= 500;

  Resource get resource {
    if (!isSucceeded) {
      return Resource.error(
        errorData: ErrorModel(
          message: isServerError
              ? message?.toString() ?? 'server_error'.tr
              : isUnAuthenticated
                  ? 'unauthenticated'.tr
                  : message ?? validationErrors ?? '',
          action: isUnAuthenticated ? APIAction.logout : APIAction.none,
        ),
      );
    }
    return Resource.success(
        data: data,
        paginationData:
            PaginationData(page: 1, totalItems: data?['total_items'] ?? 0),
        successMessage: message);
  }
}
