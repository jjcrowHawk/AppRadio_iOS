//
//  SplashController.swift
//  AppRadio
//
//  Created by Luigi Basantes on 1/2/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import Foundation
import UIKit

class SplashController : UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let second: Double = 1000000
        usleep(useconds_t(5 * second)) //will sleep for 2 milliseconds (.002 seconds)
        
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as? LoginController
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    
}
