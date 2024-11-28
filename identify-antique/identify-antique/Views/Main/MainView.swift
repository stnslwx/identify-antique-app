import SwiftUI

struct MainView: View {
    @ObservedObject var sheetModel: CollectionSheetModel
    @Binding var isMenuPresented: Bool
    @Binding var openScanner: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.bottom) {
                VStack {
                    MainTopView(isMenuPresented: $isMenuPresented, geometry: geometry)
                    Spacer()
                }
                MainScrollView(sheetModel: sheetModel, geometry: geometry, openScanner: $openScanner)
            }.frame(maxHeight: .infinity)
        }
    }
}
