import SwiftUI

struct MainView: View {
    @Binding var isMenuPresented: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.bottom) {
                VStack {
                    MainTopView(isMenuPresented: $isMenuPresented, geometry: geometry)
                    Spacer()
                }
                MainScrollView(geometry: geometry)
            }.frame(maxHeight: .infinity)
        }
    }
}
