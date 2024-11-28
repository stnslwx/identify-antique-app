import SwiftUI

struct LoadingView: View {
    
    @ObservedObject var scanner: ScannerViewModel
    @ObservedObject var collectionVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
    @StateObject private var scanModel = ScanResultModel()

    @State private var navigate: Bool = false
    
    @Binding var openScanner: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                VStack {
                    if let image = scanner.capturedPhoto {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                            .clipped()
                        
                    }
                }.edgesIgnoringSafeArea(.top)
                
                VStack {
                    Spacer()
                    ResultsView(scanModel: scanModel, navigate: $navigate, geometry: geometry)
                }
                NavigationLink(destination: ResultItemView(collectionVm: collectionVm,collectionSheetModel: collectionSheetModel,scanner: scanner, scanResult: scanModel, openScanner: $openScanner), isActive: $navigate) {
                    EmptyView()
                }
            }
            .onAppear(perform: {
                if let image = scanner.capturedPhoto {
                    scanModel.scanRequest(image: image, language: "ru")
                }
//                if let image = UIImage(named: "testimage") {
//                    // Теперь вы можете использовать `image`
//                    scanModel.scanRequest(image: image, language: "ru")
//                } else {
//                    print("Изображение не найдено в Assets")
//                }
            })
           
        }
        .navigationBarBackButtonHidden(true)
        .background(.white)
    }
    

}


