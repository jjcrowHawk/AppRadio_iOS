//
//  TextFieldRegister.swift
//  AppRadio
//
//  Created by Luigi Basantes on 1/3/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import UIKit

class TextFieldRegister : UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
                self.textColor = UIColor.black
        
        
        layer.borderWidth = 1/UIScreen.main.nativeScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height/2
        
    }
    
    func setPlaceholder(_ placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
}
