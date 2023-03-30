//
//  AudioViewController.swift
//  AVFoundationExample
//
//  Created by Benny Reyes on 29/03/23.
//

import AVFoundation
import UIKit

class AudioViewController: UIViewController {
    // Reproducción
    var player:AVAudioPlayer?
    // Captura
    @IBOutlet weak var buttonRecord:UIButton!
    let session = AVAudioSession.sharedInstance()
    var audioRecorder:AVAudioRecorder?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPermission()
    }
    
    
    // MARK: - Reproduccion
    func loadAudio(name:String, ext:String = "mp3"){
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else { return }
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            if audioPlayer.prepareToPlay() {
                audioPlayer.play()
                player = audioPlayer
                player?.play()
            }
        } catch let error {
            print(error)
        }
        
    }
    
    @IBAction func btnPlayAudioButton(_ sender: Any) {
        guard player != nil else {
            loadAudio(name: "aplausos")
            return
        }
        player?.play()
    }
    
    @IBAction func btnPauseAudioButton(_ sender: Any) {
        player?.pause()
    }
    
    // MARK: - Captura
    func checkPermission(){
        switch session.recordPermission{
        case .granted:
            // Grabar audio
            break
        case .denied:
            // Enviar alerta de settings
            break
        case .undetermined:
            requestPermission()
            break
        @unknown default:
            // Actualizaciones futuras
            break
        }
    }
    
    func requestPermission(){
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { [weak self] allowed in
                self?.buttonRecord.isEnabled = allowed
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func startRecording(){
        guard let recordURL = FileManager.getDocumentsDirectory(appendPath: "AudioExample.mp4") else { return }
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), /// El formato del audio
            AVSampleRateKey: 12000, /// Sample rate in Hertz
            AVNumberOfChannelsKey: 1, /// Numero de canales
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue /// Calidad
        ]
        do{
            audioRecorder = try AVAudioRecorder(url: recordURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
        } catch let error {
            print(error)
        }
    }
    
    func stopRecording(){
        guard let audioRecorder = audioRecorder else { return }
        audioRecorder.stop()
        buttonRecord.setTitle("Iniciar grabación", for: .normal)
        self.audioRecorder = nil
    }
    
    @IBAction func toogleRecording(){
        if audioRecorder == nil {
            startRecording()
        }else{
            stopRecording()
        }
    }
    
}

extension AudioViewController: AVAudioRecorderDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Nos avisa cuando la grabación terminó o se detuvo
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        // En caso de que suceda un error en la grabación
    }
    
}


