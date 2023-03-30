//
//  FotoVideoViewController.swift
//  AVFoundationExample
//
//  Created by Benny Reyes on 29/03/23.
//

import UIKit
import AVFoundation
import AVKit

class FotoVideoViewController: UIViewController {
    @IBOutlet weak var container:UIView!
    var player:AVPlayer?

    // MARK: - Reproducir
    func loadVideo(name:String, ext:String = "mp4", native:Bool){
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else { return }
        let videoPlayer = AVPlayer(url: url)
        if native {
            let controller = AVPlayerViewController()
            controller.player = videoPlayer
            player = videoPlayer
            present(controller, animated: true)
        } else {
            let layer = AVPlayerLayer(player: videoPlayer)
            layer.frame = container.bounds
            container.layer.addSublayer(layer)
            player = videoPlayer
            player?.play()
        }
    }
    
    @IBAction func btnPlayVideoNative(_ sender: Any) {
        loadVideo(name: "discogirando", native: true)
    }
    
    @IBAction func btnPlayVideoLayer(_ sender: Any) {
        loadVideo(name: "discogirando", native: false)
    }
    
    // MARK: - Capturar
    
    
}
