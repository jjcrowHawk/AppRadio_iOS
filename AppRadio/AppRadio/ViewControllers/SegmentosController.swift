//
//  SegmentosController.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/1/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import UserNotifications
import MediaPlayer


class SegmentosController: UIViewController {
    
    //Propiedades
    
    @IBOutlet weak var playButton: UIButton!
    
    
    enum playerStateEnum{
        case playing,stopped
    }
    
    var playerState: playerStateEnum?
    var player: AVPlayer?
    private var playerItemContext = 0
    
    @IBAction func playVideo(_ sender: AnyObject) {
        
        guard let url = URL(string: "http://str.ecuastreaming.com:9958/") else {
            return
        }
        
        let videoAsset = AVURLAsset(url: url as URL)
        let item = AVPlayerItem(asset: videoAsset)
        item.addObserver(self,
                         forKeyPath: #keyPath(AVPlayerItem.status),
                         options: [.old, .new],
                         context: &playerItemContext)
        
        self.player?.replaceCurrentItem(with: item)
        if(self.playerState == .stopped){
            self.playerState = .playing
            self.playButton.setTitle("Pause", for: UIControlState.normal)
            self.player?.play()
            print("!!!PLAYING RADIO")
        }
            
        else{
            self.player?.pause()
            self.playerState = .stopped
            self.playButton.setTitle("Play", for: UIControlState.normal)
            print("!!!!PAUSING RADIO")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerState = playerStateEnum.stopped
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        
        self.player = AVPlayer()
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect()
        self.view.layer.addSublayer(playerLayer)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
            
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
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
                    NotificationManager.notificarError(titulo: "Error de reproduccion", mensaje:"Ha ocurrido un error al reproducir la radio, vuelva a intentar luego o verifique su conexion a internet", view:self)
                    
                }
            case .unknown:
                break
                // Player item is not yet ready.
            }
        }
        
        //MARK: - Now Playing Info
        func updateNowPlayingInfoForCurrentPlaybackItem() {
           
            /*
            var nowPlayingInfo = [MPMediaItemPropertyTitle: currentPlaybackItem.trackName,
                                  MPMediaItemPropertyAlbumTitle: currentPlaybackItem.albumName,
                                  MPMediaItemPropertyArtist: currentPlaybackItem.artistName,
                                  MPMediaItemPropertyPlaybackDuration: audioPlayer.duration,
                                  MPNowPlayingInfoPropertyPlaybackRate: NSNumber(value: 1.0 as Float)] as [String : Any]
            
            if let image = UIImage(named: currentPlaybackItem.albumImageName) {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: image)
            }
            */
            //self.configureNowPlayingInfo(nowPlayingInfo as [String : AnyObject]?)
            
            
        }
    }
    
    
    
    
}
