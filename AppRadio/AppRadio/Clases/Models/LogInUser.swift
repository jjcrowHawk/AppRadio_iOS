//
//  LogInUser.swift
//  AppRadio
//
//  Created by Luigi Basantes on 11/5/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class LogInUser{
    
    var username: String
    var password: String

    
    required init(username:String, password:String) {
        self.username=username
        self.password=password
    }
    
    func getUsername() -> String{
        return self.username
    }
    func getPassword() -> String{
        return self.password
    }
}
