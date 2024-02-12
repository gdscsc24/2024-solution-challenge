import UIKit
import Flutter
import GoogleMaps  // Add this import
import GooglePlaces

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyBPTQDLzQKbxM_mO2fnxpPMiuZk2naY6Qw")
    GMSPlacesClient.provideAPIKey("AIzaSyBPTQDLzQKbxM_mO2fnxpPMiuZk2naY6Qw")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
