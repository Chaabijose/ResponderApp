import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Read Google Maps API key from secure plist file
    if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
       let plist = NSDictionary(contentsOfFile: path),
       let apiKey = plist["GOOGLE_MAPS_API_KEY"] as? String {
        GMSServices.provideAPIKey(apiKey)
    } else {
        print("Error: Could not load Google Maps API key from GoogleService-Info.plist")
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
