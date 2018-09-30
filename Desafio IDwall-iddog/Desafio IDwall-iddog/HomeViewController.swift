//
//  HomeViewController.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 30/09/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var passToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passToken)
        let url = URL(string: "https://api-iddog.idwall.co/feed")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(passToken, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                if let dataReturned = data{
                    print(dataReturned)
                }
            }else{
                print(error!.localizedDescription)
                return
            }
        }.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
