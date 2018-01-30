//
//  ServiceManagerProtocol.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 25/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation
import UIKit


protocol  ServiceManagerProtocol {
    
    func getImage(urlString : String, handler : @escaping (UIImage) -> Void)
    func getHomeSets(handler : @escaping (NetworkError?) -> Void)

}
