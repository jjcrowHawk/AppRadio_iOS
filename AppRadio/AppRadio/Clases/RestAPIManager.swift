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
    }}
