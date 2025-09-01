import 'error_model.dart';
import 'pagination_data.dart';

class Resource {
  //data
  dynamic data;
  ErrorModel? errorData;
  EStatus status;
  String? successMessage;
  PaginationData? paginationData;

  //Constructors
  Resource({this.data, this.errorData, required this.status});

  Resource.success(
      {this.data, this.paginationData, this.status = EStatus.success,this.successMessage});

  Resource.error({this.errorData, this.status = EStatus.error});

  //Checks
  bool isSuccess() => status == EStatus.success;

  bool isError() => status == EStatus.error;
}

///Request Status Values
enum EStatus { error, success }
