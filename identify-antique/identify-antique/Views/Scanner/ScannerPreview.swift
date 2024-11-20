import UIKit
import SwiftUI
import Foundation
import AVFoundation

struct ScannerPreview: UIViewRepresentable {
    
    @ObservedObject var scanner: ScannerViewModel
    
    func makeUIView(context: Context) -> UIView {
        
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height * 0.75
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
       
        let view = UIView(frame: frame)
        scanner.preview = AVCaptureVideoPreviewLayer(session: scanner.session)
        scanner.preview.frame = view.bounds
       
        scanner.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(scanner.preview)
       
        scanner.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
    
}
