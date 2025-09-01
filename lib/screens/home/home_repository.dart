import 'package:responder_app/base/base_repository.dart';

import '../../models/api/resource.dart';
import '../../utils/api_constatnts.dart';


class HomeRepository extends BaseRepository{
  Future<Resource> logout(){
    return request(callback: ()async{
      var response = await dio.post(ApiConstants.logout,);
      Resource resource = response.data;
      return resource;
    },
        pushError: true);
  }
}