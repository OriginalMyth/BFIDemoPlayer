//
//  HomeCollectionViewController.swift
//  BFIDemoPlayer
//
//  Created by Fong Bao on 25/01/2018.
//  Copyright © 2018 Fong Bao. All rights reserved.
//

import UIKit
import RxSwift

class HomeCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeTitle: UILabel!
    @IBOutlet weak var homeSynopsis: UILabel!
    @IBOutlet weak var faveButton: UIButton!
    
    var cellIsSelected: Bool?
    var indexPosition : Int?
    let cellSelectedState = PublishSubject<Int>()
    var updatedCellState : Observable<Int> {
        return cellSelectedState.asObservable()
    }

    @IBAction func faveClicked(_ sender: UIButton) {
        if let index = indexPosition {
            cellSelectedState.onNext(index)
        }
    }
}

class HomeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 2.0, right: 0.0)
    let itemsPerRow: CGFloat = 1
    var serviceManager : ServiceManagerProtocol?
    var databaseManager : DatabaseManagerProtocol?
    private let reuseIdentifier = "homeCell"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceManager = ServiceManager()
        databaseManager = SessionManager.sharedInstance
        serviceManager?.getHomeSets(handler : { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.homeCollectionView.reloadData()
                }
            } else {
                self?.showAlert(viewController: self!, title: "Network Error", message: "Please Check Connection")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (databaseManager?.homeSet.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionCell
        if let digitalItem = databaseManager?.homeSet[indexPath.row] {
            
            addObservers(entity: digitalItem, cell: cell)
            
            let selected = digitalItem.isSelected
            cell.cellIsSelected = selected
            cell.homeTitle.text = digitalItem.title
            cell.homeSynopsis.text = digitalItem.synopsis
            cell.indexPosition = indexPath.row
            if let entityImage = digitalItem.image {
                cell.homeImage.image = entityImage
            } else {
                cell.homeImage.image = UIImage(named:"image_placeholder")
            }
            cell.faveButton.setImage(selected ? UIImage(named:"heart_selected") : UIImage(named:"heart_unselected"), for: UIControlState.normal)
            observeChangeOf(cell: cell)
        }
        return cell
    }

    func observeChangeOf(cell : HomeCollectionCell) {
        cell.updatedCellState.subscribe({ [weak self] (event) in
            if let index = self?.collectionView?.indexPath(for: cell) {
                if let position = event.element {
                    let digitalItem = self?.databaseManager?.homeSet[position]
                    self?.databaseManager?.homeSet[position].isSelected = !(digitalItem?.isSelected)!
                    self?.homeCollectionView.reloadItems(at: [index])
                }
            }
        }).addDisposableTo(disposeBag)
    }
    
    func addObservers(entity : EntityProtocol, cell : HomeCollectionCell) {
        entity.updateImage.subscribe({ [weak self] event in
            DispatchQueue.main.async {
                 if let index = self?.collectionView?.indexPath(for: cell) {
                    self?.homeCollectionView.reloadItems(at: [index])
                }
            }
        }).addDisposableTo(disposeBag)
    }
    
    var selectedDigitalItem : EntityProtocol?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDigitalItem = databaseManager?.homeSet[indexPath.row]
        
        if let item = selectedDigitalItem {
        if item.items.count > 0 {
            performSegue(withIdentifier: "showEpisodes", sender: self)//has items
        } else {
            performSegue(withIdentifier: "showDetail", sender: self)
        }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {//showEpisodes
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.selectedDigitalItem = selectedDigitalItem
            }
        } else if (segue.identifier == "showEpisodes") {
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.selectedDigitalItem = selectedDigitalItem
            }
        }
    }
    
    
    //TODO: - Add a retry
    func showAlert(viewController : UIViewController, title : String, message : String) {
        let alertAction:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            viewController.dismiss(animated: true, completion: { () -> Void in
            })
        }
        let alertView:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(alertAction)
        viewController.present(alertView, animated: true, completion: { () -> Void in
            
        })
    }


}
