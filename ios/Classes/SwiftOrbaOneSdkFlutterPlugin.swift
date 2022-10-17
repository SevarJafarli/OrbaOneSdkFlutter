import Flutter
import UIKit
import Combine
import OrbaOneSdk

public class SwiftOrbaOneSdkFlutterPlugin: NSObject, FlutterPlugin {
 
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "orba_one_sdk_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftOrbaOneSdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "initialize") {
       guard let arguments: Dictionary = call.arguments as? [String: Any?] else {
          result(-1);
          return;
        }
         let apiKey: String? = arguments["apiKey"] as? String;
         let appId: String? = arguments["appId"] as? String;
    
    let config = OrbaOneConfig().setApiKey(apiKey).setApplicantId(appId).setFlow([.INTRO, .ID, .FACESCAN]).build()
    do{
let sdk = try OrbaOneFlow(configuration: config)
sdk.with(responseHandler: {response in
                switch response {
                case .success(let result):
                    print("Flow completed successfully: \(result)")
                case .failure(let error):
                    print("Flow cancelled by the user: \(error)")
                case .start:
                    print("Flow started.")
                case .error(let error):
                    switch error {
                    case .exception(withMessage: let message):
                       print("\(message)")
                    case .API_KEY_MISSING:
                        print("Publishable key missing.")
                    case .API_KEY_INVALID:
                        print("Publishable key is invalid.")
                    case .USER_INVALID:
                        print("Applicant id is invalid.")
                    case .USER_CANCELLED:
                        print("Applicant cancelled verification.")
                    case .API_NOT_AVAILABLE:
                        print("Orba One servers are unreachable.")
                    case .UPLOAD_INVALID:
                        print("Upload data is corrupted or missing meta data.")
                    @unknown default:
                        print("An unknown error occured.")
                    }
                break;
                }
            })
 var presentationStyle: UIModalPresentationStyle = .fullScreen
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                presentationStyle = .formSheet
            }
             let viewController: UIViewController =
                (UIApplication.shared.delegate?.window??.rootViewController)!;

            
            
  try sdk.startVerification(origin: viewController, style: presentationStyle)

            
    

   

    }
    catch let error {
            print("Flow not started. Error: \(error)")
        }
    }
  }
 
}
