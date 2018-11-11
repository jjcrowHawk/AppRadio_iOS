//
//  Horario.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/29/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Horario: Codable,CustomStringConvertible,Hashable{
    
    
    var fecha_inicio: String
    var fecha_fin: String
    var dia: String
    
    var description: String{
        var string = "Horario{ \n"
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let propName = child.label{
                string += " -> \(propName) = \(child.value) \n"
            }
        }
        string += "}\n"
        return string
    }
    
    var hashValue: Int{ return ObjectIdentifier(self).hashValue }
    static func ==(lhs: Horario, rhs: Horario) -> Bool {
        return lhs === rhs
    }
    
    required init(fecha_inicio:String, fecha_fin: String, dia: String){
        self.fecha_inicio=fecha_inicio;
        self.fecha_fin=fecha_fin;
        self.dia=dia;
    }
    
}
