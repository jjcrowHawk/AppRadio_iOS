//
//  Segmento.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/21/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Segmento: Codable,CustomStringConvertible{
    
    var id: Int
    var nombre: String
    var slogan: String
    var descripcion: String
    var idEmisora: Int
    var imagen: String
    var horarios: [Horario]
    
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
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.nombre = try container.decodeIfPresent(String.self, forKey: .nombre) ?? ""
        self.slogan = try container.decodeIfPresent(String.self, forKey: .slogan) ?? ""
        self.descripcion = try container.decodeIfPresent(String.self, forKey: .descripcion) ?? ""
        self.idEmisora = try container.decodeIfPresent(Int.self, forKey: .idEmisora) ?? -1
        self.imagen = try container.decodeIfPresent(String.self, forKey: .imagen) ?? ""
        self.horarios = try container.decodeIfPresent([Horario].self, forKey: .horarios) ?? []
    }
    
}
