import SwiftUI

struct ScannerView: View {
    
    @StateObject private var scanner = ScannerViewModel()
    
    @Binding var openScanner: Bool
    
    @State private var isTorchOn: Bool = false
    
    var userImage: UIImage? = nil
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    HStack {
                        Image("scannerLight").onTapGesture {
                            scanner.toggleTorch(isOn: !isTorchOn)
                            isTorchOn.toggle()
                        }
                        Spacer()
                        Image("xmarkWhite").onTapGesture {
                            openScanner = false
                            scanner.toggleTorch(isOn: false)
                            scanner.session.stopRunning()
                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .background(.black)
                    ScannerPreview(scanner: scanner)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75).background(.black)
                    
                    VStack {
                        CaptureBtn(action: {
                            scanner.takePicture()
                        })
                    }.frame(width: geometry.size.width, height: geometry.size.height * 0.15).background(.black)
                    NavigationLink(destination: LoadingView(scanner: scanner, openScanner: $openScanner) , isActive: $scanner.shouldNavigate) {
                        EmptyView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height).background(.black)
                
            }
        }
        .onAppear(perform: {
            scanner.checkCameraAuthorization()

        })
        
    }
    
    struct CaptureBtn: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                ZStack {
                    Circle().fill(.white).frame(width: 67, height: 67)
                        .overlay(alignment: .center) {
                            Image("scannerGreen")
                        }
                    Circle().stroke(Color.white, lineWidth: 4)
                        .frame(width: 77, height: 77)
                }
            }
        }
    }
    
}

