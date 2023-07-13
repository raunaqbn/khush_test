import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "image_picker_channel", binaryMessenger: controller.binaryMessenger)
    
    let imagePicker = ImagePickerViewController()
    
    channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "pickImageFromGallery" {
        self?.pickImageFromGallery(imagePicker: imagePicker, result: result)
      } else if call.method == "pickVideoFromGallery" {
        self?.pickVideoFromGallery(imagePicker: imagePicker, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func pickImageFromGallery(imagePicker: ImagePickerViewController, result: @escaping FlutterResult) {
    imagePicker.pickImageFromGallery { (imagePath: String?) in
      result(imagePath)
    }
  }
  
  private func pickVideoFromGallery(imagePicker: ImagePickerViewController, result: @escaping FlutterResult) {
    imagePicker.pickVideoFromGallery { (videoPath: String?) in
      result(videoPath)
    }
  }
}
