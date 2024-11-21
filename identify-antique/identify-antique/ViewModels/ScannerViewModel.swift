import Foundation
import SwiftUI
import AVFoundation

final class ScannerViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published var isPictureTaken: Bool = false
    
    @Published var session = AVCaptureSession()
        
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var capturedPhoto: UIImage?
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    @Published var shouldNavigate = false
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            setUpCamera()
            return
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.setUpCamera()
                }
            }
            
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
            
        }
    }
    
    func setUpCamera() {
        
        do {
            
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(output) {
                self.session.addOutput(output)
            }
            
            
            self.session.commitConfiguration()
            
        } catch  {
            
            print("Error seting up cammera: \(error.localizedDescription)")
            
        }
        
    }
    
    func takePicture() {
        
        DispatchQueue.global(qos: .background).async {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//            self.session.stopRunning()
            
            DispatchQueue.main.async {
                
                withAnimation{
                    self.isPictureTaken.toggle()
                }
                
            }
            
        }
        
    }
    
    func toggleTorch(isOn: Bool) {
        
        let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
        
        guard let device = device else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if isOn {
                    if !device.isTorchActive {
                        try device.setTorchModeOn(level: 1.0)
                    }
                } else {
                    if device.isTorchActive {
                        device.torchMode = .off
                    }
                }

                device.unlockForConfiguration()
            } catch {
                print("Error toggling torch: \(error.localizedDescription)")
            }
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            return
        }
        
        print("Photo Taken >>>")
        self.session.stopRunning()
        
        if let photoData = photo.fileDataRepresentation() {
            if let image = UIImage(data: photoData) {
                self.capturedPhoto = image
                self.shouldNavigate = true
                print("Photo saved in capturedPhoto variable/ navigate = \(shouldNavigate)")
                
            }
        }
        
    }
    
}
