//
//  JsonParserProtocol.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation


protocol JsonParserProtocol : DataParserProtocol {
    
    func parse(json : Any, handler : @escaping () -> Void)
    
}
