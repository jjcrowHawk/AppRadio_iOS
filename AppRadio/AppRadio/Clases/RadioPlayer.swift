//
//  RadioPlayer.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/3/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import UserNotifications
import MediaPlayer

class RadioPlayer : NSObject{
    //Propiedades
    enum playerStateEnum{
        case playing, stopped, muted
    }
    
    var playerState: playerStateEnum?
    var player: AVPlayer?
    var parentView: UIView
    private var playerItemContext = 0
    
    init(view: UIView) {
        self.playerState = playerStateEnum.stopped
        self.player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect()
        view.layer.addSublayer(playerLayer)
        parentView = view
    }
    
    public func playRadio(urlStream: String){
        if(self.playerState == .stopped){
            guard let url = URL(string: urlStream) else {
                return
            }
            
            let videoAsset = AVURLAsset(url: url as URL)
            let item = AVPlayerItem(asset: videoAsset)
            item.addObserver(self,
                             forKeyPath: #keyPath(AVPlayerItem.status),
                             options: [.old, .new],
                             context: &playerItemContext)
            
            self.player?.replaceCurrentItem(with: item)
            
            self.playerState = .playing
            self.player?.play()
            print("!!!PLAYING RADIO")
        }
        else{
            print("RADIO IS PLAYING OR MUTED!")
        }
    }
    
    public func pauseRadio(){
        if(self.playerState == .playing || self.playerState == .muted){
            self.player?.pause()
            self.playerState = .stopped
            print("!!!!PAUSING RADIO")
        }
    }
    
    public func resume(){
        if(self.playerState == .stopped){
            self.player?.play()
            self.playerState = .playing
            print("RESUMING RADIO")
        }
    }
    
    public func changeTrack(newUrl: String){
        guard let url = URL(string: newUrl) else {
            return
        }
        
        let videoAsset = AVURLAsset(url: url as URL)
        let item = AVPlayerItem(asset: videoAsset)
        item.addObserver(self,
                         forKeyPath: #keyPath(AVPlayerItem.status),
                         options: [.old, .new],
                         context: &playerItemContext)
        self.player?.replaceCurrentItem(with: item)
        print("Changing Track!")
    }
    
    public func muteRadio(){
        if(self.playerState == .playing){
          self.player?.volume = 0.0
            self.playerState = .muted
            print("RADIO MUTED!")
        }
    }
    
    public func raiseRadioVolume(){
        if(self.playerState == .muted){
            self.player?.volume = 1.0
            self.playerState = .playing
            print("RADIO UNMUTED!")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItemStatus
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            // Switch over status value
            switch status {
            case .readyToPlay:
                MPRemoteCommandCenter.shared().pauseCommand.addTarget{ (commandEvent) -> MPRemoteCommandHandlerStatus in
                    self.player?.play()
                    return MPRemoteCommandHandlerStatus.success
                }
                MPRemoteCommandCenter.shared().playCommand.addTarget{ (commandEvent) -> MPRemoteCommandHandlerStatus in
                    self.player?.pause()
                    return MPRemoteCommandHandlerStatus.success
                }
                break
            case .failed:
                print("ERROR OCURRED!")
                print(self.player?.currentItem?.error?.localizedDescription)
                let state = UIApplication.shared.applicationState
                if state == .background || state == .inactive {
                    NotificationManager.registerNotification(titulo: "Error de reproduccion", mensaje: "Ha ocurrido un error al reproducir la radio, vuelva a intentar luego o verifique su conexion a internet")
                }
                else{
                    /*NotificationManager.notificarError(titulo: "Error de reproduccion", mensaje:"Ha ocurrido un error al reproducir la radio, vuelva a intentar luego o verifique su conexion a internet", view:nil)*/
                    
                }
            case .unknown:
                break
                // Player item is not yet ready.
            }
        }
    }
}
