//
//  RestAPIManager.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/3/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class RestAPIManager {
    
    public static func consultarEmisoras(onSuccess: @escaping ([Emisora])-> Void, onError:@escaping (Error)->Void){
        let url = Constants.baseURL + Constants.linkEmisoras
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Token 34252ac283cbf2b3657cdd2d743c4adea4420e61", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, err) -> Void in
            if err != nil {
                onError(err!)
            }
            else{
                do{
                    let emisoras: [Emisora] = try JSONDecoder().decode([Emisora].self, from: data!)
                    onSuccess(emisoras)
                }
                catch{
                    onError(error)
                }
            }
        }
        task.resume()
    }
    
    public static func consultarSegmentos(onSuccess: @escaping ([Segmento])-> Void, onError:@escaping (Error)->Void){
        let url = Constants.baseURL + Constants.linkSegmentos
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Token 34252ac283cbf2b3657cdd2d743c4adea4420e61", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, err) -> Void in
            print(data)
            print(response)
            if err != nil {
                onError(err!)
            }
            else{
                do{
                    let segmentos: [Segmento] = try JSONDecoder().decode([Segmento].self, from: data!)
                    print(segmentos.count)
                    onSuccess(segmentos)
                }
                catch{
                    onError(error)
                }
            }
        }
        task.resume()
    }
    
    public static func consultarSegmentosEmisoraDelDia(idEmisora: Int,onSuccess: @escaping ([Segmento])-> Void, onError:@escaping (Error)->Void){
        let url = Constants.baseURL + String(format: Constants.linkSegmentosEmisoraDelDia, idEmisora)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Token 34252ac283cbf2b3657cdd2d743c4adea4420e61", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, err) -> Void in
            print(response)
            if err != nil {
                onError(err!)
            }
            else{
                do{
                    let segmentos: [Segmento] = try JSONDecoder().decode([Segmento].self, from: data!)
                    print(segmentos.count)
                    onSuccess(segmentos)
                }
                catch{
                    onError(error)
                }
            }
        }
        task.resume()
    }
    
    public static func logIn(usuario: LogInUser,onSuccess: @escaping (Token)-> Void, onError:@escaping (Error)->Void){
        let url = Constants.baseURL + String(format: Constants.linkLogIn, usuario.getUsername(),usuario.getPassword())
        let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, err) -> Void in
            print(data)
            print(response)
            if err != nil {
                onError(err!)
            }
            else{
                do{
                    let token: Token = try JSONDecoder().decode(Token.self, from: data!)
                    print(token.getKey())
                    onSuccess(token)
                }
                catch{
                    onError(error)
                }
            }
        }
        task.resume()
    }
    
}



