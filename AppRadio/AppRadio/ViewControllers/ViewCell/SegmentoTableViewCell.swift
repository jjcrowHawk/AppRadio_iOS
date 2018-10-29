//
//  SegmentoTableViewCell.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/28/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import UIKit

class SegmentoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var imagenSegmento: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layoutGuide = UILayoutGuide()
        contentView.addLayoutGuide(layoutGuide)
        
        // 2
        let topConstraint = layoutGuide.topAnchor
            .constraint(equalTo: tituloLabel.topAnchor)
        
        // 3
        let bottomConstraint = layoutGuide.bottomAnchor
            .constraint(equalTo: imagenSegmento.bottomAnchor)
        
        // 4
        let centeringConstraint = layoutGuide.centerYAnchor
            .constraint(equalTo: contentView.centerYAnchor)
        
        // 5
        NSLayoutConstraint.activate(
            [topConstraint, bottomConstraint, centeringConstraint])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
