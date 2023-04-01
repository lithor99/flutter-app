import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyBRqXyZHvFiVgoPhHpunA9-R1z2X2pJ74M")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
