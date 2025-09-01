import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/server_config.dart';
import '../helper/callback.dart';
import '../models/api/error_model.dart';
import '../models/api/resource.dart';
import '../models/user.dart';
import '../utils/api_constatnts.dart';
import '../utils/constants.dart';
import 'dio/dio_client.dart';

abstract class BaseRepository {
  /// Use [fetch,update,create,delete] ex fetchUserData(), updatePhoneNumber(), deletePost() || action name in unique cases .. and so on.

  //Dio getter
  DioClient get dioClient => Get.find();
  late Dio dio;

  BaseRepository() {
  if(pref.serverUrl != null) initDio();
  }

  void initDio(){
    dio = dioClient.dio;
  }

  //Controllers needs to disabled
  final List<StreamSubscription> _disposableList = [];

  //Paging
  final pageLimit = Constants.pageLimit;

  //error rx
  var errorObservable = ErrorModel().obs;

  void setError(ErrorModel? errorData) {
    errorObservable.value = errorData!;
  }

  /// Request methods **********************************************************

  //Generic request methods
  Future<Resource> request(
      {bool pushError = true, required RequestCallback callback}) async {
    Resource resource = await callback.call();
    if (resource.isError() && pushError && resource.errorData != null && resource.errorData!=null && resource.errorData!.action != APIAction.logout) {
      setError(resource.errorData);
    }
    if (resource.isError() && pushError && resource.errorData != null && resource.errorData!=null && resource.errorData!.action == APIAction.logout) {
      setError(resource.errorData);
      // Get.find<HomeController>().doLogout();
    }
    return resource;
  }

  ///close controllers
  void dispose() {
    errorObservable.close();
    for (StreamSubscription? controller in _disposableList) {
      if (controller != null) controller.cancel();
    }
  }

  ///Helper methods ****
  void addDisposable(StreamSubscription subscription) =>
      _disposableList.add(subscription);

  /// Shared methods ***********************************************************

  Future<Resource> getUserInfo(){
    return request(callback: ()async{
      var response = await dio.get(ApiConstants.myProfile,);
      Resource resource = response.data;
      if(resource.isSuccess()){
        resource.data = User.fromMap(resource.data);
      }
      return resource;
    },
        pushError: true);
  }

  Future<Resource> fetchServerConfig(){
    return request(callback: ()async{
      var response = await dio.get(ApiConstants.serverConfig,);
      Resource resource = response.data;
      if(resource.isSuccess()){
        resource.data = ServerConfig.fromJson(resource.data);
      }
      return resource;
    },
        pushError: true);
  }

}
