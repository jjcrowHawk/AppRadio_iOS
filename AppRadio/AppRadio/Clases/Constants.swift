//
//  Constants.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/3/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation

class Constants{
    
    //Constantes para enlaces del REST API
    public static let baseURL = "http://appradio.pythonanywhere.com"
    public static let linkEmisoras = "/api/emisoras/"
    public static let linkSegmentos = "/api/segmentos/"
    public static let linkSegmentosDelDia = "/api/segmentos/today"
    public static let linkSegmentosEmisoraDelDia = "/api/emisoras/%d/segmentos/today"
    public static let linkLogIn = "/api/rest-auth/login/"
    
}
