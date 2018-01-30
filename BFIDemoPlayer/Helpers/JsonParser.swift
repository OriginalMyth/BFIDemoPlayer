//
//  JsonParser.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation


class JsonParser : JsonParserProtocol {

    var databaseManager : DatabaseManagerProtocol
    
    init() {
        databaseManager = SessionManager.sharedInstance
    }

    func parse(json : Any, handler : @escaping () -> Void) {
        if let setArray = (json as AnyObject).object(forKey:"objects") as? NSArray {
            for digitalData in setArray {
                if let digitalDataSet = digitalData as? [String:Any] {
                    let digital = DigitalSet(json: digitalDataSet)
                    databaseManager.homeSet.append(digital)
                }
            }
            handler()
        }
    }



}


