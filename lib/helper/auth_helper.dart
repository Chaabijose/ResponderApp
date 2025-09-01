import 'dart:ffi';
import '../main.dart';

class AuthHelper {
  ///Data **********************************************************************
  bool isLoggedIn() => pref.user != null ;

  ///Logout ********************************************************************
  Future<Void?> logout() async {
    await pref.clear();
    return Future.value();
  }
}
