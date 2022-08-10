//
//  TakePhotoViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 27.07.2022.
//

import UIKit
import AVFoundation

class TakePhotoViewController: UIViewController, Storyboarded {

    // Capture Session
    var session: AVCaptureSession?
    // Photo Output
    let output = AVCapturePhotoOutput()
    // Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    // Shutter Button
    // Fotoyu çekmek için bir button oluşturduk.
    private let shutterButton: UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        btn.layer.cornerRadius = 40
        btn.layer.borderWidth = 10
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preview layer kamerayı önizlemek içindir. Burada layer'ı ekliyoruz.
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layer tüm ekranı kaplasın diyoruz.
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 70)
    }
    
    @objc private func didTapTakePhoto() {
        // Foto çek tuşuna basıldığında fotoyu çek diyoruz.
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    // Burada camera izinlerini kontrol ediyoruz.
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {return}
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCamera()
        }
    }
    
    // Burada kamerayı ayarlıyoruz.
    private func setupCamera() {
        let session = AVCaptureSession()
        
        // Önce bir session açıyoruz, sonra device'ı ayarlıyoruz.
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                
                // Sonra input ve outputu device'a ekliyoruz.
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                // Preview için session'ı ayarlıyoruz.
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                // Video yakalamaya başla diyoruz ve self session'a atıyoruz.
                session.startRunning()
                self.session = session
                
            } catch {
                print(error)
            }
        }
    }

}

extension TakePhotoViewController : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        // didFinish metodunda fotoyu yakalıyoruz. Önce içinden datayı alıyoruz.
        guard let data = photo.fileDataRepresentation() else {return}
        
        // Sonra image'a çevirip session'ı durduruyoruz.
        let image = UIImage(data: data)
        session?.stopRunning()
        
        // Daha sonra o fotoyu bir imageView'a koyup tüm ekranda gösteriyoruz.
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}
