
//
//  File.swift
//  BitTicker
//
//  Created by Amuri Arun Kumar on 2/6/19.
//  Copyright © 2019 Amuri Arun Kumar. All rights reserved.
//

import Foundation
import Starscream
import FirebaseAuth

protocol BTNetworkServicesDelegate {
    func updateMarketValues(newData: BTTicker)
}
enum ChannelEnum: Int {
    case ticker = 1002
}
class BTNetworkServices: NSObject {
    private static let shared = BTNetworkServices()
    override private init() {}
    var delegate: BTNetworkServicesDelegate?
    class func sharedInstance() -> BTNetworkServices {
        return shared
    }
    let socket: WebSocket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
    var command: String!
    func getTickerUpdates(channelId: ChannelEnum){
        command  = "{\"command\":\"subscribe\",\"channel\":\(channelId.rawValue)}"
        socket.delegate = self
        socket.connect()
    }
}
extension BTNetworkServices: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        socket.write(string: command)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        if let data = text.data(using: .utf16) {
            do{
                guard let jsonData = try? JSONSerialization.jsonObject(with: data) as! [Any] else {
                    return
                }
                if jsonData.count > 2 {
                    if let detailsArray  = jsonData.last as? [AnyObject] {
                        let tickerData = BTTicker(marketDetails: detailsArray)
                        delegate?.updateMarketValues(newData: tickerData)
                    }
                }
            }
            catch let error as NSError{
                print("sometyhing asdasd \(error.localizedDescription)")
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("socket received message data")
    }
    func loginWithUserDetails(userName: String, password: String, completionHandler: @escaping(_ status: Bool) -> Void){
        Auth.auth().signIn(withEmail: userName, password: password) { (user, error) in
            error == nil ? completionHandler(true) : completionHandler(false)
        }
    }
    func createAccount(userName: String, password: String, completionHandler: @escaping(_ status: Bool) -> Void) {
        Auth.auth().createUser(withEmail: userName, password: password) { (authResult, error) in
            error == nil ? completionHandler(true) : completionHandler(false)
        }
    }
    
   
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            socket.disconnect()
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
