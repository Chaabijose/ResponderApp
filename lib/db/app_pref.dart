import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:responder_app/models/server_config.dart';
import '../models/unit.dart';
import '../models/user.dart';

/// Storage Keys ***************************************************************
enum PreferenceKeys {
  keyAppLocal,
  keyUserToken,
  keyUserRefreshToken,
  keyUser,
  keyUserGuide,
  keyTheme,
  keyServerUrl,
  keyServerConfig,
  keyPreviousUnits,
  keyMyUnit,
}

class AppPreferences {
  //Data
  late GetStorage _storage;

  //init
  Future<void> init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  ///App Locale ****************************************************************
  String? currentLocal() {
    return _storage.read(PreferenceKeys.keyAppLocal.toString()); // Language
  }

  void setCurrentLocale(String? language) {
    _storage.write(PreferenceKeys.keyAppLocal.toString(), language);
  }


  ///Server Url ****************************************************************
  String? get serverUrl => _storage.read(PreferenceKeys.keyServerUrl.toString());

  set serverUrl(String? url) {
    _storage.write(PreferenceKeys.keyServerUrl.toString(), url);
  }

  ///Server Config ****************************************************************
  set serverConfig(ServerConfig? serverConfig) {
    String data = jsonEncode(serverConfig!.toJson());
    _storage.write(PreferenceKeys.keyServerConfig.toString(), data);
  }

  ServerConfig? get serverConfig {
    String dataStr = _storage.read(PreferenceKeys.keyServerConfig.toString()) ?? "";
    if (dataStr.isEmpty) return null;
    return ServerConfig.fromJson(json.decode(dataStr));
  }

  ///My Unit ****************************************************************
  set myUnit(Unit? unit) {
    String data = jsonEncode(unit!.toJson());
    _storage.write(PreferenceKeys.keyMyUnit.toString(), data);
  }

  Unit? get myUnit {
    String dataStr = _storage.read(PreferenceKeys.keyMyUnit.toString()) ?? "";
    if (dataStr.isEmpty) return null;
    return Unit.fromJson(json.decode(dataStr));
  }

  ///previous  Units ****************************************************************
  List<Unit>? get previousUnits {
      String unitsStr = _storage.read(PreferenceKeys.keyPreviousUnits.toString()) ?? "";
      if (unitsStr.isEmpty) return null;
      var list = unitsStr.split('%%%%%');
      List<Unit>? allUnits = <Unit>[];
      for (var element in list) {
        if(element.isNotEmpty)allUnits.add(Unit.fromJson(json.decode(element)));
      }
      return allUnits.isEmpty ? null : allUnits;
  }

  set previousUnits(List<Unit>? units) {
    String look ='';
    units?.forEach((element) {
      look =  '$look${jsonEncode(element.toJson())}%%%%%';
    });
    _storage.write(PreferenceKeys.keyPreviousUnits.toString(), look);
  }

  /// User Guide ****************************************************************
  set tookUserGuide(bool value) {
    _storage.write(PreferenceKeys.keyUserGuide.toString(), value);
  }

  bool get isTookUserGuide =>
      _storage.read(PreferenceKeys.keyUserGuide.toString()) ?? false;

  /// Token ********************************************************************
  set userToken(String? userToken) =>
      _storage.write(PreferenceKeys.keyUserToken.toString(), userToken);

  String? get userToken =>
      _storage.read(PreferenceKeys.keyUserToken.toString());

  /// Refresh -Token ***********************************************************
  set userRefreshToken(String? token) =>
      _storage.write(PreferenceKeys.keyUserRefreshToken.toString(), token);

  String? get userRefreshToken =>
      _storage.read(PreferenceKeys.keyUserRefreshToken.toString());

  ///User data *************************************************
  set user(User? client) {
    String user = jsonEncode(client!.toMap());
    _storage.write(PreferenceKeys.keyUser.toString(), user);
  }

  User? get user {
    String clientStr = _storage.read(PreferenceKeys.keyUser.toString()) ?? "";
    if (clientStr.isEmpty) return null;
    return User.fromMap(json.decode(clientStr));
  }

  /// Theme ****************************************************************
  set darkTheme(bool value){
    _storage.write(PreferenceKeys.keyTheme.toString(), value);
  }

  bool get darkTheme => _storage.read(PreferenceKeys.keyTheme.toString()) ?? false;



  ///Clear *********************************************************************
  Future<void> clear() async {
    String? local = currentLocal();
    String? url = serverUrl;
    var units = previousUnits;
    ServerConfig? config = serverConfig;

    await _storage.erase();

    setCurrentLocale(local);
    serverUrl = url;
    previousUnits = units;
    serverConfig = config;

  }
}
