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

struct DogStruct : Decodable{
    let category : String
    let list : [String]
    
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var passToken = ""
    var arrayDogs : [String] = ["husky","labrador","hound","pug"]
    var ltDogs = [DogStruct]()
    
    public var errorCode: Int?
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for item in self.arrayDogs {
                self.fetchItemsFromApi(dog: item, key: self.passToken)
                }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(passToken)
       

        self.collectionView?.dataSource = self
        self.collectionView?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ltDogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.dogBreedLabel.text = self.ltDogs[indexPath.row].category
        let poster_path = self.ltDogs[indexPath.row].list[0]
        print(poster_path)
                let dogImageURL = URL(string: poster_path)
                if let dataImage = NSData(contentsOf: dogImageURL!){
                    cell.dogImage.image = UIImage(data: dataImage as Data)
                }
        
        return cell
    }
    
    
    func fetchItemsFromApi(dog : String, key : String)  {
        let url = URL(string: "https://api-iddog.idwall.co/feed?category=\(dog)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(key, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else{return}
                do{
                    
                    let dog = try JSONDecoder().decode(DogStruct.self, from: data)
                    self.ltDogs.append(dog)
                    self.collectionView?.reloadData()
                }catch let jsonErr{
                    print("Error serializing json: ",jsonErr)
                }
            }
        }.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
