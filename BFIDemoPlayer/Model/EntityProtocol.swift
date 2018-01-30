//
//  EntityProtocol.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol EntityProtocol {
    
    var title : String { get }
    var isSelected : Bool {get set}
    var synopsis : String { get }
    var image : UIImage? {get set }
    var items : [Any] {get }
    var updateImage : Observable<Void> {get}
}
