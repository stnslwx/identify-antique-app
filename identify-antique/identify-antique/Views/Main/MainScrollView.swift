import SwiftUI

struct MainScrollView: View {
    @ObservedObject var sheetModel: CollectionSheetModel
    //let geometry: GeometryProxy
    
    @Binding var openScanner: Bool
    @Binding var showPaywall: Bool
    var body: some View {
        VStack(spacing: 14) {
            MainActiveSection(openScanner: $openScanner, showPaywall: $showPaywall)
            MainPopularSection(openScanner: $openScanner)
            MainArticlesView(sheetModel: sheetModel)
        }.padding(.bottom, 280)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("mainBgColor"))
        .cornerRadius(37)
    }
}
