import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.bottom) {
                VStack {
                    MainTopView(geometry: geometry)
                    Spacer()
                }
                MainScrollView(geometry: geometry)
            }.frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    MainView()
}
