//
//  HomeCollectionViewController.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 30/09/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation
import Alamofire
private let reuseIdentifier = "customCell"

class HomeCollectionViewController: UICollectionViewController {

    /*var passToken = ""
    var husky : String = "husky"
    var labrador : String = "labrador"
    var hound : String = "hound"
    var pug : String = "pug"
    var dogObj = [Dogs]()
    public var errorCode: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        
            self.fetchItemsFromApi(dog: self.husky, key: self.passToken)
            self.fetchItemsFromApi(dog: self.labrador, key: self.passToken)
            self.fetchItemsFromApi(dog: self.hound, key: self.passToken)
            self.fetchItemsFromApi(dog: self.pug, key: self.passToken)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passToken)
        self.collectionView?.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.dataSource = self
        self.collectionView?.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func fetchItemsFromApi(dog : String, key : String) {
        let headers: HTTPHeaders = [
            "Authorization" : key,
            "Content-Type" : "application/json"
        ]
        DispatchQueue.main.async {
            Alamofire.request("https://api-iddog.idwall.co/feed?category=\(dog)", headers: headers).responseString(completionHandler: { (response) in
                switch response.result{
                case .success(let responseString):
                    let itemResponse = Dogs(JSONString: "\(responseString)")
                    self.dogObj.append(itemResponse!)
                    print((itemResponse?.category)!)
                    print((itemResponse?.ltImageURL)!)
                case .failure(let error):
                    self.errorCode = error as? Int
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (self.dogObj.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.dogBreedLabel.text = dogObj[indexPath.row].category
//        let poster_path = dogObj[indexPath.row].ltImageURL![0]
//        let dogImageURL = URL(string: poster_path)
//        if let dataImage = NSData(contentsOf: dogImageURL!){
//            cell.dogImage.image = UIImage(data: dataImage as Data)
//        }
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
*/
}
