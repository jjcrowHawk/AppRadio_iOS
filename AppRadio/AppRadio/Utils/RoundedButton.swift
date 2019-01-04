//
//  RoundedButton.swift
//  AppRadio
//
//  Created by Luigi Basantes on 1/3/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1/UIScreen.main.nativeScale
        contentEdgeInsets = UIEdgeInsets(top: 0,left: 16,bottom: 0,right: 16)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.borderColor = tintColor.cgColor
    }
}
