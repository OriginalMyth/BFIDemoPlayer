//
//  SessionManager.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation


class SessionManager : DatabaseManagerProtocol {
   
    var homeSet: [EntityProtocol] = [EntityProtocol]()
    static let sharedInstance = SessionManager()
    private var digitalSetArray = [EntityProtocol]()
    
    private init(){
    }
    
}
