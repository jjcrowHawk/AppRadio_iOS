//
//  LoginController.swift
//  AppRadio
//
//  Created by Luigi Basantes on 11/5/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import UIKit


class LoginController : UIViewController{
    
    //Elementos del UI
    @IBOutlet var tfUsername : TextFieldLogin!{
        didSet {
            tfUsername.tintColor = UIColor.lightGray
            tfUsername.setIcon(UIImage(named: "icon_user")!)
            tfUsername.setPlaceholder("Usuario")
        }
    }
    
    @IBOutlet var tfPassword : TextFieldLogin!{
        didSet {
            tfPassword.tintColor = UIColor.lightGray
            tfPassword.setIcon(UIImage(named: "icon_password")!)
            tfPassword.setPlaceholder("Contraseña")
        }
    }
    
    
    @IBOutlet var btnLogin : UIButton!
    
    @IBOutlet weak var imgRadio: UIImageView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        print( tfUsername.text! )
        print( tfPassword.text! )
        var user : LogInUser = LogInUser(username : tfUsername.text!,password : tfPassword.text!)
        
        RestAPIManager.logIn(
            usuario: user,
            onSuccess: {segmentos in DispatchQueue.main.async{
                
                
                }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! SegmentosController
                self.present(vc, animated: true, completion: nil)
            },
            onError: {error in
                print("\n Error \(error) ocurred: \(error.localizedDescription)")
            }
        )
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
