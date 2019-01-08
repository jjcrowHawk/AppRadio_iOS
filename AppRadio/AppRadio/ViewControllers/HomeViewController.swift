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
    @IBOutlet weak var apagarButton: UIButton!
    @IBOutlet weak var silenciarButton: UIButton!
    
    //properties
    var items : [Int] = [1,2,3,4,5]
    var emisorasDataset : [Emisora] = []
    var segmentosDelDiaDataset : [Segmento] = []
    var reproduccionDataset :Dictionary<Emisora,Segmento?> = [:]
    var datasetEmisoraSegmento: [(Emisora,Segmento?)] = []
    var encendido : Bool = true
    var silenciado : Bool = false
    var radioPlayer : RadioPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioPlayer = RadioPlayer(view: self.view)
        
        /* GUI CHANGES */
        carousel.type = .rotary
        
        //This change the radius of the button corners
        let maskPath1 = UIBezierPath(roundedRect: silenciarButton.bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = silenciarButton.bounds
        maskLayer1.path = maskPath1.cgPath
        silenciarButton.layer.mask = maskLayer1
        
        let maskPath2 = UIBezierPath(roundedRect: apagarButton.bounds,
                                     byRoundingCorners: [.topLeft, .bottomLeft],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = apagarButton.bounds
        maskLayer2.path = maskPath2.cgPath
        apagarButton.layer.mask = maskLayer2
        
        apagarButton.backgroundColor = #colorLiteral(red: 1, green: 0.5729322433, blue: 0, alpha: 1)
        
        /*Llamadas al API*/
        RestAPIManager.obtenerEmisoras(onSuccess: {emisoras in DispatchQueue.main.async {
            print("EMISORAS OBTENIDAS")
            self.emisorasDataset = emisoras
            
            //Se repite este proceso en la otra llamada para evitar las condiciones de carrera
            if self.segmentosDelDiaDataset.count != 0 {
                for emisora in self.emisorasDataset{
                    for segmento in self.segmentosDelDiaDataset{
                        if segmento.idEmisora == emisora.id{
                            self.reproduccionDataset[emisora] = segmento
                            break
                        }
                    }
                    if self.reproduccionDataset[emisora] == nil{
                        
                        self.reproduccionDataset[emisora] = nil as Segmento?
                    }
                }
                
                self.datasetEmisoraSegmento = self.reproduccionDataset.sorted(by: { $0.key.nombre! < $1.key.nombre! })
                print(self.datasetEmisoraSegmento.count)
                print(self.emisorasDataset.count)
                self.carousel.reloadData()
            }
            
            self.radioPlayer?.playRadio(urlStream: emisoras[0].urlStreaming!)
            //self.carousel.reloadData()
        }},
            onError: {error in
                print("\(error): \(error.localizedDescription)")
            }
        )
        
        RestAPIManager.obtenerSegmentosDelDia(onSuccess: {segmentos in DispatchQueue.main.async{
            print("SEGMENTOS OBTENIDOS")
            self.segmentosDelDiaDataset = segmentos
            if self.emisorasDataset.count != 0 {
                for emisora in self.emisorasDataset{
                    for segmento in segmentos{
                        if segmento.idEmisora == emisora.id{
                            self.reproduccionDataset[emisora] = segmento
                            break
                        }
                    }
                    if self.reproduccionDataset[emisora] == nil{

                        self.reproduccionDataset[emisora] = nil as Segmento?
                    }
                }
                
                self.datasetEmisoraSegmento = self.reproduccionDataset.sorted(by: { $0.key.nombre! < $1.key.nombre! })
                print(self.datasetEmisoraSegmento.count)
                print(self.emisorasDataset.count)
                self.carousel.reloadData()
            }
            else{
                print("RACE CONDITION!!!")
            }
        }}, onError: {error in
            print("\(error): \(error.localizedDescription)")
            self.carousel.reloadData()
        })
        
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return emisorasDataset.count
    }
    
    //Button Event Handlers
    @IBAction func iniciarRadio(_ sender: UIButton){
        print("encendido!")
        if encendido == false {
            apagarButton.backgroundColor = #colorLiteral(red: 1, green: 0.5729322433, blue: 0, alpha: 1)
            self.radioPlayer?.resume()
            encendido = true
        }
        else{
            apagarButton.backgroundColor = #colorLiteral(red: 0.1097919717, green: 0.109810628, blue: 0.1097856238, alpha: 1)
            self.radioPlayer?.pauseRadio()
            encendido = false
        }
        
    }
    
    @IBAction func silenciarRadio(_ sender: UIButton) {
        print("apagado!")
        if silenciado == false{
            silenciarButton.backgroundColor =  #colorLiteral(red: 1, green: 0.5729322433, blue: 0, alpha: 1)
            self.radioPlayer?.muteRadio()
            silenciado = true
        }
        else{
            silenciarButton.backgroundColor =  #colorLiteral(red: 0.1097919717, green: 0.109810628, blue: 0.1097856238, alpha: 1)
            self.radioPlayer?.raiseRadioVolume()
            silenciado = false
        }
        
    }
    
    //Implementation of carousel protocols
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let sizeFrame = CGRect(x: 0, y: 0, width: self.carousel.frame.width - 30, height: self.carousel.frame.height - 8)
        let view = HomeEmisoraView(frame: sizeFrame)
        //let view = HomeEmisoraView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        if datasetEmisoraSegmento.count != 0{
            view.tituloEmisora.text = self.datasetEmisoraSegmento[index].0.nombre
            view.labelFrecuencia.text = self.datasetEmisoraSegmento[index].0.frecuenciaDial
            if(self.datasetEmisoraSegmento[index].1 != nil){
                view.labelSegmento.text = self.datasetEmisoraSegmento[index].1?.nombre
                var horaInicio : String = (self.datasetEmisoraSegmento[index].1?.horarios![0].fechaInicio)!
                var horaFin : String = (self.datasetEmisoraSegmento[index].1?.horarios![0].fechaFin)!
                horaInicio = String(horaInicio.prefix(upTo: horaInicio.index(horaInicio.endIndex, offsetBy: -3)))
                horaFin = String(horaFin.prefix(upTo: horaFin.index(horaFin.endIndex,offsetBy: -3)))
                view.labelHorarioTransmision.text = "\(horaInicio) - \(horaFin)"
                Alamofire.request((self.datasetEmisoraSegmento[index].1?.imagen)!).responseImage(completionHandler: {response in
                    let filter = BlurFilter(blurRadius: 0)
                    view.imgSegmentoActual.image = filter.filter(response.result.value!)
                })
            }
            else{
                view.labelSegmento.text = "Informacion no disponible"
                view.labelHorarioTransmision.isHidden = true
                view.favoritoButton.isHidden = true
                view.labelProgramaFavorito.isHidden = true
                
                Alamofire.request(datasetEmisoraSegmento[index].0.logotipo!).responseImage(completionHandler: {response in
                    let filter = BlurFilter(blurRadius: 0)
                    view.imgSegmentoActual.image = filter.filter(response.result.value!)
                })
            }
        }
        else{
            view.tituloEmisora.text = emisorasDataset[index].nombre
            view.labelFrecuencia.text = emisorasDataset[index].frecuenciaDial
            view.labelSegmento.text = "Informacion no disponible"
            view.labelHorarioTransmision.isHidden = true
            view.favoritoButton.isHidden = true
            view.labelProgramaFavorito.isHidden = true
            
            Alamofire.request(emisorasDataset[index].logotipo!).responseImage(completionHandler: {response in
                let filter = BlurFilter(blurRadius: 0)
                view.imgSegmentoActual.image = filter.filter(response.result.value!)
            })
        }
        
        return view
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if(emisorasDataset.count != 0){
            print("-> CURRENT INDEX \(carousel.currentItemIndex): \(self.datasetEmisoraSegmento[carousel.currentItemIndex].0.nombre)")
            let url : String = self.datasetEmisoraSegmento[carousel.currentItemIndex].0.urlStreaming!
            self.radioPlayer?.changeTrack(newUrl: url)
        }
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
