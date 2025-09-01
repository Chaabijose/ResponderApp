import 'package:responder_app/base/base_repository.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/user.dart';
import 'package:responder_app/utils/constants.dart';
import '../../models/api/resource.dart';
import '../../utils/api_constatnts.dart';

class AuthRepository extends BaseRepository{
  Future<Resource> login({required String userName,required String password}){
    return request(callback: ()async{

      var response = await dio.post(ApiConstants.login, data: {
        Constants.userName : userName,
        Constants.password : password,
        Constants.organizationCode : pref.serverConfig?.code,
      },);

      Resource resource = response.data;
      if(resource.isSuccess()){
        pref.userToken = resource.data[Constants.accessToken];
        pref.userRefreshToken = resource.data[Constants.refreshToken];
        resource.data = User.fromMap(resource.data[Constants.employee]);
      }
      return resource;
    });
  }

}