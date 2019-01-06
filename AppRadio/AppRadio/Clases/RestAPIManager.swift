//
//  RestAPIManager.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/3/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RestAPIManager {
    
    /* Este metodo es usado sin librerias, al pelo :v */
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
    
    /* Este metodo es usando AlamoFire*/
    public static func obtenerEmisoras(onSuccess: @escaping ([Emisora]) -> Void,onError: @escaping (Error) -> Void){
        let headers: HTTPHeaders = [
            "Authorization": "Token 34252ac283cbf2b3657cdd2d743c4adea4420e61",
            "Accept": "application/json",
            "Content": "application/json"
        ]
        let url = Constants.baseURL + Constants.linkEmisoras
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseArray{(response: DataResponse<[Emisora]>) in
            
            switch response.result{
                case .success:
                    onSuccess(response.result.value!)
            
                case .failure(let error):
                    onError(error)
            }
        }
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
        let parameters = ["username": usuario.getUsername(), "email": "", "password": usuario.getPassword() ]
        
        //let url = Constants.baseURL + String(format: Constants.linkLogIn, usuario.getUsername(),usuario.getPassword())
        let url = URL(string: Constants.baseURL + Constants.linkLogIn)!
        
        //let request: NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            print(data)
            print(response)
            guard error == nil else {
                return
            }
            guard let data = data else {
                
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        
        
        
        
        
        
        /*
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
        task.resume()*/
    }
    
}



