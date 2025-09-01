class ErrorModel {
  final APIAction action;
  final String? message;

  ErrorModel({this.action = APIAction.none, this.message});
}

enum APIAction { logout, refreshToken, none }
