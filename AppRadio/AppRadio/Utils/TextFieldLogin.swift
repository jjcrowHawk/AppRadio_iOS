//
//  TextFieldLogin.swift
//  AppRadio
//
//  Created by Luigi Basantes on 1/3/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import UIKit

class TextFieldLogin : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.textColor = UIColor.white
        
        
        
        //LINEA INFERIOR
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 10, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.white.cgColor
        
    }
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setPlaceholder(_ placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
}
