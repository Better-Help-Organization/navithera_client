import UIKit
import Flutter
import PushKit
import flutter_callkit_incoming

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Register for VoIP notifications
        let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Handle the VoIP Push Token
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        let token = credentials.token.map { String(format: "%02.2hhx", $0) }.joined()
        print("VoIP Token: \(token)")
        
        // Pass the VoIP token to Flutter so it can be retrieved during login
        SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(token)
    }

    // Handle the Incoming VoIP Notification
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        print("VoIP Push received: \(payload.dictionaryPayload)")
        
        // Parse the nested JSON data from the payload
        var room: String = ""
        var chatId: String = ""
        var token: String = ""
        var isVideoCall: Bool = false
        var isGroupCall: Bool = false
        var callerName: String = "Incoming Call"
        
        // Try to get data from the "id" field (which contains JSON string)
        if let idValue = payload.dictionaryPayload["id"] {
            var idDict: [String: Any]? = nil
            
            // Check if it's already a dictionary
            if let dict = idValue as? [String: Any] {
                idDict = dict
            }
            // Check if it's a JSON string that needs parsing
            else if let jsonString = idValue as? String,
                    let jsonData = jsonString.data(using: .utf8),
                    let parsed = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                idDict = parsed
            }
            
            if let idDict = idDict {
                room = idDict["room"] as? String ?? ""
                chatId = idDict["chatId"] as? String ?? ""
                token = idDict["token"] as? String ?? ""
                isVideoCall = idDict["isVideoCall"] as? Bool ?? false
                isGroupCall = idDict["isGroupCall"] as? Bool ?? false
                
                // Get caller name from callerData
                if let callerData = idDict["callerData"] as? [String: Any] {
                    let firstName = callerData["firstName"] as? String ?? ""
                    let lastName = callerData["lastName"] as? String ?? ""
                    let fullName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
                    if !fullName.isEmpty {
                        callerName = fullName
                    }
                }
            }
        }
        
        // Fallback: check "data" -> "id" structure
        if room.isEmpty, let dataDict = payload.dictionaryPayload["data"] as? [String: Any] {
            if let idJsonString = dataDict["id"] as? String,
               let jsonData = idJsonString.data(using: .utf8),
               let idDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                room = idDict["room"] as? String ?? ""
                chatId = idDict["chatId"] as? String ?? ""
                token = idDict["token"] as? String ?? ""
                isVideoCall = idDict["isVideoCall"] as? Bool ?? false
                isGroupCall = idDict["isGroupCall"] as? Bool ?? false
                
                if let callerData = idDict["callerData"] as? [String: Any] {
                    let firstName = callerData["firstName"] as? String ?? ""
                    let lastName = callerData["lastName"] as? String ?? ""
                    let fullName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
                    if !fullName.isEmpty {
                        callerName = fullName
                    }
                }
            }
        }
        
        print("Parsed call data - room: \(room), chatId: \(chatId), caller: \(callerName), isVideo: \(isVideoCall)")
        
        // Generate a UUID for this call
        let callUUID = UUID().uuidString
        
        // Determine call type (0 = audio, 1 = video)
        let callType = isVideoCall ? 1 : 0
        
        // Create the CallKit Data object
        let callData = flutter_callkit_incoming.Data(
            id: callUUID,
            nameCaller: callerName,
            handle: callerName,
            type: callType
        )
        
        // Set additional fields
        callData.appName = "Navithera"
        callData.duration = 30000
        callData.supportsVideo = true
        
        // Put all required data into extra so Flutter can access it
        let extraDict: NSMutableDictionary = [
            "uuid": callUUID,
            "room": room,
            "chatId": chatId,
            "token": token,
            "isVideoCall": isVideoCall,
            "isGroupCall": isGroupCall,
            "callerName": callerName
        ]
        callData.extra = extraDict
        
        print("CallKit extra data: \(extraDict)")
        
        // Show the CallKit incoming call UI
        SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(callData, fromPushKit: true)
        
        // Report to system that we handled it
        completion()
    }
    
    // Handle token invalidation
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("VoIP token invalidated")
    }
}
