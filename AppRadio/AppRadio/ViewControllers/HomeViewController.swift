//
//  HomeViewController.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 1/6/19.
//  Copyright © 2019 InnovaSystem. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController, iCarouselDelegate, iCarouselDataSource{
    
    //GUI properties
    @IBOutlet weak var carousel: iCarousel!
    
    //properties
    var items : [Int] = [1,2,3,4,5]
    var emisorasDataset : [Emisora] = []
    var reproduccionDataset :Dictionary<Emisora,Segmento> = [:]
    var datasetEmisoraSegmento: [(Emisora,Segmento)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        RestAPIManager.obtenerEmisoras(onSuccess: {emisoras in DispatchQueue.main.async {
            print(emisoras)
            self.emisorasDataset = emisoras
            self.carousel.reloadData()
        }},
            onError: {error in
                print("\(error): \(error.localizedDescription)")
            }
        )
        
        RestAPIManager.obtenerSegmentosDelDia(onSuccess: {segmentos in DispatchQueue.main.async{
            print(segmentos)
            if self.emisorasDataset.count != 0 {
                for emisora in self.emisorasDataset{
                    for segmento in segmentos{
                        if segmento.idEmisora == emisora.id{
                            self.reproduccionDataset[emisora] = segmento
                            break
                        }
                    }
                    if self.reproduccionDataset[emisora] == nil{
                        self.reproduccionDataset[emisora] = nil
                    }
                }
                 self.datasetEmisoraSegmento = self.reproduccionDataset.sorted(by: { $0.key.nombre! < $1.key.nombre! })
                self.carousel.reloadData()
            }
        }}, onError: {error in
            print("\(error): \(error.localizedDescription)")
        })
        
        carousel.type = .rotary
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return emisorasDataset.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = HomeEmisoraView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        if reproduccionDataset.count != 0{
            let datasetIndex = self.reproduccionDataset.index(self.reproduccionDataset.startIndex, offsetBy: index)
            view.tituloEmisora.text = self.datasetEmisoraSegmento[index].0.nombre//self.reproduccionDataset[datasetIndex].key.nombre
            view.labelFrecuencia.text = self.datasetEmisoraSegmento[index].0.frecuenciaDial //self.reproduccionDataset[datasetIndex].key.frecuenciaDial
            if(self.datasetEmisoraSegmento[index].1 != nil){
                view.labelSegmento.text = self.datasetEmisoraSegmento[index].1.nombre//self.reproduccionDataset[datasetIndex].value.nombre
                view.labelHorarioTransmision.text = "\(self.datasetEmisoraSegmento[index].1.horarios![0].fechaInicio) - \(self.datasetEmisoraSegmento[index].1.horarios![0].fechaFin)"
                //"\(self.reproduccionDataset[datasetIndex].value.horarios![0].fechaInicio) - \(self.reproduccionDataset[datasetIndex].value.horarios![0].fechaFin)"
            }
        }
        else{
            view.tituloEmisora.text = emisorasDataset[index].nombre
            view.labelFrecuencia.text = emisorasDataset[index].frecuenciaDial
            view.labelSegmento.text = "Informacion no disponible"
            view.labelHorarioTransmision.isHidden = true
        }
        
        Alamofire.request(emisorasDataset[index].logotipo!).responseImage(completionHandler: {response in
            let filter = BlurFilter(blurRadius: 1)
            view.imgSegmentoActual.image = filter.filter(response.result.value!)
        })
        
        return view
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        return value
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
