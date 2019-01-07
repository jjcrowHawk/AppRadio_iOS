//
//  HomeEmisoraView.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 1/6/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import UIKit

class HomeEmisoraView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var tituloEmisora: UILabel!
    @IBOutlet weak var imgSegmentoActual: UIImageView!
    @IBOutlet weak var labelFrecuencia: UILabel!
    @IBOutlet weak var labelSegmento: UILabel!
    @IBOutlet weak var labelHorarioTransmision: UILabel!
    @IBOutlet weak var favoritoButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    
    override
    init(frame: CGRect) {                   //Metodo para iniciar  por codigo
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {           //Metodo para inciar por el IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("HomeEmisoraView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
