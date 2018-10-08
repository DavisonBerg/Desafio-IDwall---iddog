//
//  HomeViewController.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 04/10/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import UIKit
import Foundation


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
        cell.dogImage.isUserInteractionEnabled = true
        cell.dogImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
        //cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
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
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    
    @objc func handleZoomTap(tapGesture: UITapGestureRecognizer){
        if let imageView = tapGesture.view as? UIImageView{
            startingFrame = imageView.superview?.convert(imageView.frame, to: nil)
            
            let zoomingImageView = UIImageView(frame: startingFrame!)
            zoomingImageView.image = imageView.image
            zoomingImageView.isUserInteractionEnabled = true
            zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            
            if let keyWindow = UIApplication.shared.keyWindow{
                blackBackgroundView = UIView(frame: keyWindow.frame)
                blackBackgroundView?.backgroundColor = UIColor.black
                blackBackgroundView?.alpha = 0
                keyWindow.addSubview(blackBackgroundView!)
                
                keyWindow.addSubview(zoomingImageView)
                //Animate zoom
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackBackgroundView?.alpha = 1
                    
                    let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                    
                    zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                    zoomingImageView.center = keyWindow.center
                }, completion: nil)
            }
        }
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer){
        if let zoomOutImageView = tapGesture.view{
            //Animate back out to controller
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }) { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            }
        }
    }
}
