import 'package:responder_app/base/base_repository.dart';
import 'package:responder_app/models/unit.dart';

import '../../../models/api/resource.dart';
import '../../../utils/api_constatnts.dart';

class RegisterUnitRepository extends BaseRepository{
  Future<Resource> fetchUnits(){
    return request(callback: ()async{
      var response = await dio.get(ApiConstants.units,);
      Resource resource = response.data;
      if(resource.isSuccess()){
        resource.data = (resource.data as List).map((item)=>Unit.fromJson(item)).toList();
      }
      return resource;
    },);
  }


}