//
//  Emisora.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/21/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Emisora: Codable,CustomStringConvertible{
    
    var id: Int
    var nombre: String
    var frecuencia_dial: String
    var url_streaming: String
    var sitio_web: String
    var direccion: String
    var descripcion: String
    var ciudad: String
    var provincia: String
    var logotipo: String
    
    var description: String{
        var string = "Emisora{ \n"
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
