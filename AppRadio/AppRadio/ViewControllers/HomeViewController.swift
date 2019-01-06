//
//  HomeViewController.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 1/6/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var carousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        print("\nWITH ALAMOFIRE: ")
        RestAPIManager.obtenerEmisoras(onSuccess: {emisoras in DispatchQueue.main.async {
            for emisora in emisoras{
                print(emisora)
            }
        }},
            onError: {error in
                print("\(error): \(error.localizedDescription)")
            }
        )
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
