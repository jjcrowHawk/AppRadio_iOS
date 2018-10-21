//
//  Segmento.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/21/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Segmento: Codable,CustomStringConvertible{
    
    //var id: Int
    var nombre: String
    var slogan: String
    var descripcion: String
    var idEmisora: Int
    var imagen: String
    
    var description: String{
        var string = "Segmento{ \n"
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let propName = child.label{
                string += " -> \(propName) = \(child.value) \n"
            }
        }
        string += "}\n"
        return string
        
    }
}
