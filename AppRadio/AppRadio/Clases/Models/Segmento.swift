//
//  Segmento.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/21/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import ObjectMapper


class Segmento : NSObject, NSCoding, Mappable{
    
    var descripcion : String?
    var emisora : Emisora?
    var horarios : [Horario]?
    var id : Int?
    var idEmisora : Int?
    var imagen : String?
    var nombre : String?
    
    override
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
    
    class func newInstance(map: Map) -> Mappable?{
        return Segmento()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        descripcion <- map["descripcion"]
        emisora <- map["emisora"]
        horarios <- map["horarios"]
        id <- map["id"]
        idEmisora <- map["idEmisora"]
        imagen <- map["imagen"]
        nombre <- map["nombre"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        descripcion = aDecoder.decodeObject(forKey: "descripcion") as? String
        emisora = aDecoder.decodeObject(forKey: "emisora") as? Emisora
        horarios = aDecoder.decodeObject(forKey: "horarios") as? [Horario]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        idEmisora = aDecoder.decodeObject(forKey: "idEmisora") as? Int
        imagen = aDecoder.decodeObject(forKey: "imagen") as? String
        nombre = aDecoder.decodeObject(forKey: "nombre") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if descripcion != nil{
            aCoder.encodeConditionalObject(descripcion, forKey: "descripcion")
        }
        if emisora != nil{
            aCoder.encode(emisora, forKey: "emisora")
        }
        if horarios != nil{
            aCoder.encode(horarios, forKey: "horarios")
        }
        if id != nil{
            aCoder.encodeConditionalObject(id, forKey: "id")
        }
        if idEmisora != nil{
            aCoder.encodeConditionalObject(idEmisora, forKey: "idEmisora")
        }
        if imagen != nil{
            aCoder.encodeConditionalObject(imagen, forKey: "imagen")
        }
        if nombre != nil{
            aCoder.encodeConditionalObject(nombre, forKey: "nombre")
        }
        
    }
    
}
