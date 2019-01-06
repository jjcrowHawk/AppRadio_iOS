//
//  Emisora.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/21/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import ObjectMapper


class Emisora : NSObject, NSCoding, Mappable{
    
    var ciudad : String?
    var descripcion : String?
    var direccion : String?
    var frecuenciaDial : String?
    var id : Int?
    var logotipo : String?
    var nombre : String?
    var provincia : String?
    var sitioWeb : String?
    var urlStreaming : String?
    
    override
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
    
    class func newInstance(map: Map) -> Mappable?{
        return Emisora()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        ciudad <- map["ciudad"]
        descripcion <- map["descripcion"]
        direccion <- map["direccion"]
        frecuenciaDial <- map["frecuencia_dial"]
        id <- map["id"]
        logotipo <- map["logotipo"]
        nombre <- map["nombre"]
        provincia <- map["provincia"]
        sitioWeb <- map["sitio_web"]
        urlStreaming <- map["url_streaming"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        ciudad = aDecoder.decodeObject(forKey: "ciudad") as? String
        descripcion = aDecoder.decodeObject(forKey: "descripcion") as? String
        direccion = aDecoder.decodeObject(forKey: "direccion") as? String
        frecuenciaDial = aDecoder.decodeObject(forKey: "frecuencia_dial") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        logotipo = aDecoder.decodeObject(forKey: "logotipo") as? String
        nombre = aDecoder.decodeObject(forKey: "nombre") as? String
        provincia = aDecoder.decodeObject(forKey: "provincia") as? String
        sitioWeb = aDecoder.decodeObject(forKey: "sitio_web") as? String
        urlStreaming = aDecoder.decodeObject(forKey: "url_streaming") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if ciudad != nil{
            aCoder.encodeConditionalObject(ciudad, forKey: "ciudad")
        }
        if descripcion != nil{
            aCoder.encodeConditionalObject(descripcion, forKey: "descripcion")
        }
        if direccion != nil{
            aCoder.encodeConditionalObject(direccion, forKey: "direccion")
        }
        if frecuenciaDial != nil{
            aCoder.encodeConditionalObject(frecuenciaDial, forKey: "frecuencia_dial")
        }
        if id != nil{
            aCoder.encodeConditionalObject(id, forKey: "id")
        }
        if logotipo != nil{
            aCoder.encodeConditionalObject(logotipo, forKey: "logotipo")
        }
        if nombre != nil{
            aCoder.encodeConditionalObject(nombre, forKey: "nombre")
        }
        if provincia != nil{
            aCoder.encodeConditionalObject(provincia, forKey: "provincia")
        }
        if sitioWeb != nil{
            aCoder.encodeConditionalObject(sitioWeb, forKey: "sitio_web")
        }
        if urlStreaming != nil{
            aCoder.encodeConditionalObject(urlStreaming, forKey: "url_streaming")
        }
        
    }
    
}
