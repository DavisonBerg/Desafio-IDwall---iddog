//
//  HomeViewController.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 04/10/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation
import Alamofire
import PromiseKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var passToken = ""
    var husky : String = "husky"
    var labrador : String = "labrador"
    var hound : String = "hound"
    var pug : String = "pug"
    var dogObj = [Dogs]()
    public var errorCode: Int?
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.fetchItemsFromApi(dog: self.husky, key: self.passToken)
            self.fetchItemsFromApi(dog: self.labrador, key: self.passToken)
            self.fetchItemsFromApi(dog: self.hound, key: self.passToken)
            self.fetchItemsFromApi(dog: self.pug, key: self.passToken)
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(passToken)
        
        self.collectionView?.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes

        self.collectionView?.dataSource = self
        self.collectionView?.dataSource = self
        let dog1 = fetchItemsFromApi(dog: husky, key: passToken)
        let dog2 = fetchItemsFromApi(dog: labrador, key: passToken)
        let dog3 = fetchItemsFromApi(dog: hound, key: passToken)
        let dog4 = fetchItemsFromApi(dog: pug, key: passToken)
        let ltdog = [Promise<Any>].self
       
        print(self.dogObj)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogObj.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.dogBreedLabel.text = dogObj[indexPath.row].category
                let poster_path = dogObj[indexPath.row].ltImageURL![0]
        print(poster_path)
                let dogImageURL = URL(string: poster_path)
                if let dataImage = NSData(contentsOf: dogImageURL!){
                    cell.dogImage.image = UIImage(data: dataImage as Data)
                }
        // Configure the cell
        
        return cell
    }
    
    
    func fetchItemsFromApi(dog : String, key : String) -> Promise<Dogs>{
        let headers: HTTPHeaders = [
            "Authorization" : key,
            "Content-Type" : "application/json"
        ]
        return Promise{seal in
            
            return Alamofire.request("https://api-iddog.idwall.co/feed?category=\(dog)", headers: headers).responseString { (response) in
                switch(response.result){
                //repositories
                case .success(let responseString):
                    //print(responseString)
                    let itemResponse = Dogs(JSONString:"\(responseString)")
                    self.dogObj.append(itemResponse!)
                    seal.fulfill(itemResponse!)
                case .failure(let error):
                    print(error)
                    seal.reject(error)
                }
            }
        }
        
        
    }
    /*
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
                   
                    //print(itemResponse!)
                    self.dogObj.append(itemResponse!)
                    print(self.dogObj)
                    //print((itemResponse?.category)!)
                    //print((itemResponse?.ltImageURL)!)
                case .failure(let error):
                    self.errorCode = error as? Int
    
                }
            })
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
