//
//  ServerRequest.swift
//  JetDevsHomeWork
//
//  Created by Harshil on 14/12/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class ServerRequest {
    
    /// Singleton object
    static let shared = ServerRequest()
    let semaphore = DispatchSemaphore(value: 1)
    var storedAuthHeader = [String: String]()
    
    class var isConnected: Bool {
        let manager = NetworkReachabilityManager.init(host: "www.google.com")
        return manager?.isReachable ?? false
    }
    func loginUser(credentials:Credentials,
        completion: ((BaseAPIResult)-> Swift.Void)? = nil,failure:((String)->Void)? = nil ){
         
        var dictParam:[String:String] = [:]
        dictParam["email"] = credentials.email
        dictParam["password"] = credentials.password
        
        AF.request("https://jetdevs.mocklab.io/login" , method: .post , parameters: dictParam, encoding: JSONEncoding.default , headers: nil).responseJSON { (response) in

            print("Login request \(response.request)")
            switch response.result
            {
            case .success(let value):
                let responseJSON = JSON.init(value)
                print("login Response \(responseJSON)")
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let result = BaseAPIResult(responseJSON)
                    completion?(result)
                
                default:
                    failure?("somthing is wrong")

                }
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
    }
    
}
