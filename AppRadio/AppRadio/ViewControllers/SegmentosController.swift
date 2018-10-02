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
import MediaPlayer


class SegmentosController: UIViewController {
    
    //Propiedades
    
    @IBOutlet weak var playButton: UIButton!
    
    
    enum playerStateEnum{
        case playing,stopped
    }
    
    var playerState: playerStateEnum?
    var player: AVPlayer?
    
    @IBAction func playVideo(_ sender: AnyObject) {
        // TODO
        
        /*guard let url = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8") else {
            return
        }*/
        
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
        guard let url = URL(string: "http://str.ecuastreaming.com:9958/") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let videoAsset = AVURLAsset(url: url as URL)
        let item = AVPlayerItem(asset: videoAsset)
        self.player = AVPlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect()
        self.view.layer.addSublayer(playerLayer)
        //self.playButton.titleLabel?.text = "Play"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
