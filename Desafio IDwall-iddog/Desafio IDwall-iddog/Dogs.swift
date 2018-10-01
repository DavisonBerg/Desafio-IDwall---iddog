//
//  Dogs.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 01/10/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import Foundation
public class Dogs : Decodable{
    
    /*public var husky:String
    public var hound:String
    public var pug:String?
    public var labrador:String
    
    
    public enum UserResponseKeys: String, CodingKey{
        case husky = "husky"
        case hound = "hound"
        case pug = "pug"
        case labrador = "labrador"
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: UserResponseKeys.self)
        
        self.husky = try container.decode(String.self, forKey: .husky)
        self.hound = try container.decode(String.self, forKey: .hound)
        self.pug = try container.decodeIfPresent(String.self, forKey: .pug)
        self.labrador = try container.decode(String.self, forKey: .labrador)
    }*/
    
    public var husky=""
    public var hound=""
    public var pug=""
    public var labrador=""
    
    
    public enum UserResponseKeys: String, CodingKey{
        case husky = "husky"
        case hound = "hound"
        case pug = "pug"
        case labrador = "labrador"
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserResponseKeys.self)
        //self.name = try container.decodeWrapper(key: .name, defaultValue: "husky")
    }
    
    
    
}
