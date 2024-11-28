import SwiftUI
import PhotosUI

struct ScannerView: View {
    
    @ObservedObject var collectionVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
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
                    .background(Color("0b0b0b"))
                    ScannerPreview(scanner: scanner)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75).background(Color("0b0b0b"))
                        .overlay(alignment: .center) {
//                            Image("scannerFrame")
//                                .resizable()
//                                .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                            SelectionRect(scanModel: scanner)
                        }
                    
                    VStack {
                        HStack {
                            PhotosPicker(selection: $scanner.imageSelection, matching: .images) {
                                RoundedRectangle(cornerRadius: 12).fill(Color("1b1b1b")).frame(width: 60, height: 60)
                                    .overlay(alignment: .center) {
                                    Image("gallery")
                                }
                            }
                            //OpenGalleryBtn(action: {print("gallery")})
                            Spacer()
                        }
                        .overlay(alignment: .center) {
                            CaptureBtn(action: {
                                scanner.takePicture()
                            })
                        }
                    }
                    .padding(.horizontal, 40)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.15).background(Color("0b0b0b"))
                    NavigationLink(destination: LoadingView(scanner: scanner, collectionVm: collectionVm,collectionSheetModel: collectionSheetModel, openScanner: $openScanner) , isActive: $scanner.shouldNavigate) {
                        EmptyView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height).background(Color("0b0b0b"))
                
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
    
    struct OpenGalleryBtn: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                RoundedRectangle(cornerRadius: 12).fill(Color("1b1b1b")).frame(width: 60, height: 60)
                    .overlay(alignment: .center) {
                    Image("gallery")
                }
            }
        }
    }
}

