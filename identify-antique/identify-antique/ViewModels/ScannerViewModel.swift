import Foundation
import SwiftUI
import AVFoundation
import PhotosUI

final class ScannerViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published var isPictureTaken: Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var capturedPhoto: UIImage?
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var shouldNavigate = false
    @Published var squareRect: CGRect = .zero
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet{
            setSelectedImage(from: imageSelection)
        }
    }
    
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
            
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                let input = try AVCaptureDeviceInput(device: device)
                
                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }
                
                if self.session.canAddOutput(output) {
                    self.session.addOutput(output)
                }
            }
            
            self.session.commitConfiguration()
            
        } catch  {
            
            print("Error seting up cammera: \(error.localizedDescription)")
            
        }
        
    }
    
    func takePicture() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.preview.connection?.isEnabled = false 
            }
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                withAnimation{
                    self.isPictureTaken.toggle()
                }
            }
        }
    }
    
    
    func updateSquareRect(for screenSize: CGSize, squareSize: CGFloat, gestureSizeChange: CGFloat) {
        let currentSize = squareSize + gestureSizeChange
        let originX = (screenSize.width - currentSize) / 2
        let originY = (screenSize.height - currentSize) / 2
        self.squareRect = CGRect(x: originX, y: originY, width: currentSize, height: currentSize)
    }

    
    private func cropImage(from originalImage: UIImage, toSizeOf rect: CGRect) -> UIImage? {

        guard let cgImage = originalImage.cgImage else { return nil}
        let outputRect = preview.metadataOutputRectConverted(fromLayerRect: rect)

        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)

        let cropRect = CGRect(
            x: (outputRect.origin.x * width),
            y: (outputRect.origin.y * height),
            width: (outputRect.size.width * width),
            height: (outputRect.size.height * height)
        )

        if let cropedCGImage = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: cropedCGImage, scale: 1.0, orientation: originalImage.imageOrientation)
        }

        return nil
     
    }
    
    private func setSelectedImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.shouldNavigate = true
                    DispatchQueue.global(qos: .background).async {
                        self.capturedPhoto = uiImage
                        self.session.stopRunning()
                    }
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
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()
        }
             
        if let photoData = photo.fileDataRepresentation() {
            if let image = UIImage(data: photoData) {
                if let croppedImage = cropImage(from: image, toSizeOf: squareRect) {
                    self.capturedPhoto = croppedImage
                    self.shouldNavigate = true
                    print("Photo saved in capturedPhoto variable/ navigate = \(shouldNavigate) >>>")
                }
            }
        }
        
    }
    
}
