import SwiftUI

struct LoadingView: View {
    
    @ObservedObject var scanner: ScannerViewModel
    @State private var isLoading: Bool = true
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
                    ResultsView(isLoading: $isLoading, navigate: $navigate, geometry: geometry)
                }
                NavigationLink(destination: ResultItemView(isConfirmationalView: true, openScanner: $openScanner), isActive: $navigate) {
                    EmptyView()
                }
            }
           
        }
        .navigationBarBackButtonHidden(true)
        .background(.white)
    }
    

}


