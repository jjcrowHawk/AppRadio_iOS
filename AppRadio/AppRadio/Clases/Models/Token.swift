//
//  File.swift
//  AppRadio
//
//  Created by Luigi Basantes on 11/5/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Token: Codable{
    
    var key:String
    
    init(key:String){
        self.key=key
    }
    
    func getKey()->String{
        return self.key
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
    }
    
}
