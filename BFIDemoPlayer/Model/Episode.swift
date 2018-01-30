//
//  Episode.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

struct Episode : EntityProtocol {
    
    let synopsis : String
    let digitalSetUid : String
    let selfUrl : String
    let title : String
    let body : String
    var image : UIImage? = nil
    var items = [Any]()
    var isSelected = false
    var imageUrls = [String]()
    let imageReturned = PublishSubject<Void>()
    var updateImage : Observable<Void> {
        return imageReturned.asObservable()
    }
    
    init(json : [String : Any]) {
        title = json["title"] as! String
        synopsis = json["synopsis"] as! String
        selfUrl = json["self"] as! String
        digitalSetUid = json["uid"] as! String
        body = json["body"] as! String
        
    }
    
}
