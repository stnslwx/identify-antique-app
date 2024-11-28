import SwiftUI

struct MainScrollView: View {
    @ObservedObject var sheetModel: CollectionSheetModel
    let geometry: GeometryProxy
    @Binding var openScanner: Bool
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 14) {
                MainActiveSection(openScanner: $openScanner)
                MainPopularSection(openScanner: $openScanner)
                MainArticlesView(sheetModel: sheetModel)
            }.padding(.bottom, 140)
        }
        .padding()
        .frame(width: geometry.size.width, height: geometry.size.height * 0.768)
        .background(Color("mainBgColor"))
        .cornerRadius(37)
    }
}
