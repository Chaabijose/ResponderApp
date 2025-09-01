import 'package:dio/dio.dart' as dio_app;
import 'package:get/get.dart';
import 'package:responder_app/base/base_repository.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/server_health.dart';
import '../../../base/dio/dio_client.dart';
import '../../../models/api/api_response.dart';
import '../../../models/api/error_model.dart';
import '../../../models/api/resource.dart';
import '../../../utils/api_constatnts.dart';

class ServerConfigRepository extends BaseRepository{
  late dio_app.Dio myDio;
   getMyDio({required String serverUrl}){
     myDio = dio_app.Dio(
        dio_app.BaseOptions(
          baseUrl: '$serverUrl/api/',
          contentType: 'application/json; charset=utf-8',
          headers: {'accept': 'application/json; charset=utf-8'},
          validateStatus: (code) {
            return code != null && code >= 200 && code <= 500;
          },
        )
    );

    myDio.interceptors.add(dio_app.InterceptorsWrapper(onRequest:
        (dio_app.RequestOptions options,
        dio_app.RequestInterceptorHandler handler) {
      options.headers.addAll(_headers);
      handler.next(options);
    }, onResponse: (response, handler) async{
      if(response.statusCode == 404){
        response.data = Resource(status: EStatus.error,errorData: ErrorModel(
          action: APIAction.none,
          message: 'wrong_url'.tr
        ));
        handler.next(response);
        return;
      }
      print('Thrwat ${response.data}');
      if(response.data is Map){
        var apiResponse = ApiResponse.fromMap(response.data);
        response.data = apiResponse.resource;
      }else{
        response.data = Resource(status: EStatus.error,errorData: ErrorModel(message: 'wrong_server_url'.tr,action: APIAction.none));
      }
      handler.next(response);
    }, onError:
        (dio_app.DioException e, dio_app.ErrorInterceptorHandler handler) async{

      handler.resolve(_handleError(
        e,
      ));
    }));

    return myDio;
  }

  Map<String, String> get _headers {
    Map<String, String> headers = {};
    headers.putIfAbsent(
        "Content-Type", () => "application/json; charset=utf-8");
    headers.putIfAbsent("accept", () => "application/json; charset=utf-8");
    headers.putIfAbsent("User-Agent", () => "mobile");
    return headers;
  }

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

  Future<Resource> checkHealth({required String serverUrl}){
    return request(callback: ()async{
      getMyDio(serverUrl: serverUrl);

      var response = await myDio.get(ApiConstants.checkHealth,);
      Resource resource = response.data;
      if(resource.isSuccess()){
        resource.data = ServerHealth.fromJson(resource.data);
        pref.serverUrl = serverUrl;
       Get.put(DioClient(),permanent: true);
        initDio();
      }
      return resource;
    },
        pushError: false);
  }

/*  Future<Resource> getServerData(){
    return request(callback: ()async{
      var response = await myDio.get(ApiConstants.serverConfig,);
      Resource resource = response.data;
      if(resource.isSuccess()){
        resource.data = ServerConfig.fromJson(resource.data);
      }
      return resource;
    },
        pushError: true);
  }*/

}