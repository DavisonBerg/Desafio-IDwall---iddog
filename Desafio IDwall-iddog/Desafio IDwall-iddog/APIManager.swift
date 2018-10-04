//
//  APIManager.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 03/10/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class APIManager{
    static let shared = APIManager()
    public var errorCode: Int?
    
    private init(){
        
    }
    
    
        /*return Promise<[Dogs]>{
            fullfil,reject -> Void in
            return Alamofire.request("https://api-iddog.idwall.co/feed?category=\(dog)").responseString{ (response) in
                switch(response.result){
                    
                case .success(let responseString):
                    let itemResponse = Dogs(JSONString: "\(responseString)")
                    fullfil(itemResponse?)
                case .failure(let error):
                    if let code = reponse.response?.statusCode{
                        self.errorCode = code
                        reject(error)
                    }
                
                }
                
            }
        
    }*/
}
