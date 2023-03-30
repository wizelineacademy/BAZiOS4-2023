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
    // Reproducir
    @IBOutlet private weak var container:UIView!
    private var player:AVPlayer?
    // Capturar
    private let session = AVCaptureSession()
    private var videoOutput:AVCaptureMovieFileOutput?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPermission()
    }

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
    
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            print("Puede usar la camara")
            self.setupCaptureSession()
            break
        case .denied, .restricted:
            print("No se puede usar la camara")
            break
        case .notDetermined:
            print("Solicitar permiso al usuario")
            requestPermission()
            break
        @unknown default:
            // Futuras actualizaciones
            break
        }
    }
    
    func requestPermission(){
        AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
            // Iniciar a grabar
            if status {
                self?.setupCaptureSession()
            }
        }
    }
    
    func setupCaptureSession(){
        session.beginConfiguration()
        // Agregar
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .back)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            session.canAddInput(videoDeviceInput)
            else { return }
        session.addInput(videoDeviceInput)
        prepareOutput()
    }
    
    func prepareOutput(){
        self.videoOutput = AVCaptureMovieFileOutput()
        guard session.canAddOutput(videoOutput!) else { return }
        session.addOutput(videoOutput!)
        session.commitConfiguration()
        session.startRunning()
        print("Start running")
        
    }
    
    @IBAction func startRecording(){
        guard let url = FileManager.getDocumentsDirectory(appendPath: "videoRecorder.mp4"), session.isRunning else { return }
        print("Start running pressed")
        videoOutput?.startRecording(to: url, recordingDelegate: self)
    }
    
    @IBAction func stopRecording(completion: @escaping (Error?) -> Void) {
        
        if session.isRunning && (videoOutput?.isRecording ?? false) {
            print("Start running stop")
            self.videoOutput?.stopRecording()
        }
    }
    
}

// MARK: - AVCaptureFileOutputRecordingDelegate


extension FotoVideoViewController: AVCaptureFileOutputRecordingDelegate{
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Benny || didStartRecordingTo")
        // Notifica que el video empezo la grabacion
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("Benny || didFinishRecordingTo error:\(error?.localizedDescription)")
        // Notifica cuando termina de grabar, la url de destino, y si hay algun error
    }
    
}
