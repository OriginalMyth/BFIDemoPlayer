//
//  ServiceManager.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 25/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation
import Alamofire

class ServiceManager : ServiceManagerProtocol {
    
    let jsonParser : JsonParserProtocol
    
    init() {
        jsonParser = JsonParser()
    }

    func getImage(urlString : String, handler : @escaping (UIImage) -> Void) {
        Alamofire.request(urlString).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value {
                    if let refData = json as? [String:Any] {
                        let imageUrl = refData["url"] as! String
                        Alamofire.request(imageUrl).responseData { response in
                            if let error = response.result.error as? AFError{
                                print("request errored error.responseCode is \(String(describing: error.responseCode)) ... error.errorDescription is \(String(describing: error.errorDescription))")
                            } else if response.result.isSuccess {
                                if let data = response.result.value {
                                    if let image = UIImage(data: data) {
                                        handler(image)
                                    }
                                } else {
                                    print("Invalid response")
                                }
                            } else {
                                print("request failed response.response?.statusCode\(String(describing: response.response?.statusCode))")
                            }
                        }
                    }
                } else {
                    //Invalid response
                    print("Invalid response")
                }
                
            }else {
                //request failed
                print("request failed response.response?.statusCode\(String(describing: response.response?.statusCode))")
            }
        }
    }
    
    func getHomeSets(handler : @escaping (NetworkError?) -> Void) {
        Alamofire.request(Constants.getAllSetsUrl).responseJSON { [weak self] response in
            if let error = response.result.error as? AFError{
                //request errored
                print("request errored error.responseCode is \(String(describing: error.responseCode)) ... error.errorDescription is \(String(describing: error.errorDescription))")
                handler(NetworkError.networkError)
            } else if response.result.isSuccess {
                
                if let json = response.result.value {
                    self?.jsonParser.parse(json: json, handler: {
                        handler(nil)
                    })
                } else {
                    //Invalid response
                    print("Invalid response")
                    handler(NetworkError.networkError)
                }
            } else {
                //request failed
                print("request failed response.response?.statusCode\(String(describing: response.response?.statusCode))")
                handler(NetworkError.networkError)
            }
        }
    }
    
    

}
