//
//  EpisodeDetailViewController.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 25/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var synopsisView: UILabel!
    
    var selectedDigitalItem : EntityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = selectedDigitalItem?.image {
            imageView.image = image
        }
        titleView.text = selectedDigitalItem?.title
        synopsisView.text = selectedDigitalItem?.synopsis
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
