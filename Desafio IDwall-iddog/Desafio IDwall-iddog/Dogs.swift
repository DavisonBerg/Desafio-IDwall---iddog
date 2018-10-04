//
//  Dogs.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 01/10/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import Foundation
import ObjectMapper

public class Dogs : Mappable{
    
    
    var category: String?
    var ltImageURL : [String]?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        category <- map["category"]
        ltImageURL <- map["list"]
    }
    
}
