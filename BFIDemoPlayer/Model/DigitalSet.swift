//
//  Set.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 29/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DigitalSet : EntityProtocol {
    
    let digitalSetUid : String
    let selfUrl : String
    let title : String
    let synopsis : String
    let body : String
    var isSelected = false
    var imageUrls = [String]()
    var episodes = [Episode]()
    var image : UIImage? = nil
    var items = [Any]()
    let serviceManager : ServiceManagerProtocol = ServiceManager()
    let imageReturned = PublishSubject<Void>()
    var updateImage : Observable<Void> {
        return imageReturned.asObservable()
    }
    
    init(json : [String : Any]) {
        synopsis = json["summary"] as! String
        digitalSetUid = json["uid"] as! String
        selfUrl = json["self"] as! String
        title = json["title"] as! String
        body = json["body"] as! String
        imageUrls = json["image_urls"] as! [String]
        items = json["items"] as! [Any]
        if let firstImage = imageUrls.first {
            print("firstImage \(firstImage)")
            fetchDigitalSetImage(url : firstImage)
        }
    }
    
    func fetchDigitalSetImage(url : String) {
        serviceManager.getImage(urlString: Constants.baseUrl + url, handler: { [weak self] image in
            self?.image = image
            DispatchQueue.main.async {
                self?.imageReturned.onNext()
            }
        })
    }
    
}
