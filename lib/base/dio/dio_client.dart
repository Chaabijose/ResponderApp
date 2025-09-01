import 'package:dio/dio.dart' as dio_app;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as get_x;
import 'package:get/get.dart';
import 'package:network_logger/network_logger.dart';
import '../../helper/auth_helper.dart';
import '../../main.dart';
import '../../models/api/api_response.dart';
import '../../models/api/error_model.dart';
import '../../models/api/resource.dart';
import '../../navigation/app_routes.dart';
import 'logger.dart';

class DioClient {
  /// Data & constructor *************************************
  late dio_app.Dio dio;

  String get apiVersion => "/api/";

  String get baseUrl => pref.serverUrl! + apiVersion;

  DioClient() {
    dio = dio_app.Dio(dio_app.BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json; charset=utf-8',
      headers: {'accept': 'application/json; charset=utf-8'},
      validateStatus: (code) {
        return code != null && code >= 200 && code <= 500;
      },
    ));
    addInterceptor(dio);
  }

  void addInterceptor(dio_app.Dio dio) {
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(DioNetworkLogger());

    dio.interceptors.add(dio_app.InterceptorsWrapper(onRequest:
        (dio_app.RequestOptions options,
        dio_app.RequestInterceptorHandler handler) {
      options.headers.addAll(_headers);
      handler.next(options);
    }, onResponse: (response, handler) async{
      if(response.statusCode == 401 && pref.userToken != null){
        await Get.find<AuthHelper>().logout();
        Get.offAllNamed(Routes.auth);
      }
      var apiResponse = ApiResponse.fromMap(response.data);
      response.data = apiResponse.resource;
      handler.next(response);
    }, onError:
        (dio_app.DioException e, dio_app.ErrorInterceptorHandler handler) async{
      if(e.response!= null && e.response!.statusCode == 401 && pref.userToken != null){
        await Get.find<AuthHelper>().logout();
        Get.offAllNamed(Routes.auth);
      }

      handler.resolve(_handleError(
        e,
      ));
    }));
  }

  /// Add Headers **************************************************************
  Map<String, String> get _headers {
    Map<String, String> headers = {};
    headers.putIfAbsent(
        "Content-Type", () => "application/json; charset=utf-8");
    headers.putIfAbsent("accept", () => "application/json; charset=utf-8");
    headers.putIfAbsent("User-Agent", () => "mobile");

    String? token = pref.userToken;
    if (token != null && token.isNotEmpty) {
      debugPrint("Token: $token");
      headers.putIfAbsent("Authorization", () => "Bearer $token");
    }
    return headers;
  }

  static Map<String, String> addMultipartHeader() {
    return {
      'Authorization': 'Bearer ${pref.userToken}',
      'Content-type': dio_app.Headers.multipartFormDataContentType,
      'accept': dio_app.Headers.jsonContentType,
    };
  }

  static Map<String, dynamic>? addParams(
      {int? take, int? page, Map<String, dynamic>? otherParam}) {
    Map<String, dynamic> params = {};
    if (take != null && page != null) {
      params.addAll({
        'take': take.toString(),
        'page': page.toString(),
      });
    }

    if (otherParam != null) params.addAll(otherParam);

    return params;
  }

  /// Error Handler ************************************************************
  dio_app.Response _handleError(dio_app.DioException error) {
    switch (error.type) {
      case dio_app.DioExceptionType.connectionTimeout:
      case dio_app.DioExceptionType.sendTimeout:
      case dio_app.DioExceptionType.receiveTimeout:
      case dio_app.DioExceptionType.badCertificate:
      case dio_app.DioExceptionType.connectionError:
      case dio_app.DioExceptionType.badResponse:
        var resource = Resource.error(
            errorData: ErrorModel(
                message: error.message ??
                    error.error?.toString() ??
                    'no_internet_connection'.tr));
        return dio_app.Response(
            requestOptions: error.requestOptions,
            data: resource,
            statusMessage: error.message,
            statusCode: error.response?.statusCode);

      case dio_app.DioExceptionType.unknown:
      case dio_app.DioExceptionType.cancel:
        var resource = Resource.error(
            errorData: ErrorModel(
              message: error.message != null
                  ? error.message!
                  : (error.error != null &&
                  error.error!.toString() ==
                      'Null check operator used on a null value')
                  ? error.message?.toString() ??
                  error.error?.toString() ??
                  error.stackTrace.toString()
                  : error.error?.toString() ?? 'unauthenticated'.tr,
              action: (error.error != null &&
                  error.error!.toString() ==
                      'Null check operator used on a null value')
                  ? APIAction.none
                  : APIAction.logout,
            ));
        return dio_app.Response(
            requestOptions: error.requestOptions,
            data: resource,
            statusMessage: error.message,
            statusCode: error.response?.statusCode);

      }
  }
}
