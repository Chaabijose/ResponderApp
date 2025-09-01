import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../utils/paths.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor? appFlavor;
  static Map<dynamic, dynamic>? config;

  static bool isDev() => appFlavor == Flavor.dev;

  ///Fetch config file depending on env
  static Future<void> init() async {
    try {
      String jsonContent = await rootBundle.loadString(appFlavor == Flavor.prod
          ? "${jsonPath}config-prod.json"
          : "${jsonPath}config.json");
      config = json.decode(jsonContent);
    } catch (e, trace) {
      debugPrint(trace.toString());
    }
  }

  static String get baseUrl => config!['base_url'];
  static String get azureClientId => config!['azure_client_id'];
  static String get azureTenantId => config!['azure_tenant_id'];
  static String get azureRedirectUrl => config!['azure_redirect_url'];
  static String get azureClientSecret => config!['azure_client_secret'];

}
