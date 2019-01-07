//
//  Horario.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/29/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import ObjectMapper


class Horario : NSObject, NSCoding, Mappable{
    
    var dia : String?
    var fechaFin : String?
    var fechaInicio : String?
    
    override
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
    
    class func newInstance(map: Map) -> Mappable?{
        return Horario()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        dia <- map["dia"]
        fechaFin <- map["fecha_fin"]
        fechaInicio <- map["fecha_inicio"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dia = aDecoder.decodeObject(forKey: "dia") as? String
        fechaFin = aDecoder.decodeObject(forKey: "fecha_fin") as? String
        fechaInicio = aDecoder.decodeObject(forKey: "fecha_inicio") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if dia != nil{
            aCoder.encodeConditionalObject(dia, forKey: "dia")
        }
        if fechaFin != nil{
            aCoder.encodeConditionalObject(fechaFin, forKey: "fecha_fin")
        }
        if fechaInicio != nil{
            aCoder.encodeConditionalObject(fechaInicio, forKey: "fecha_inicio")
        }
        
    }
    
}
