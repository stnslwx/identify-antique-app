import SwiftUI

struct MainScrollView: View {
    let geometry: GeometryProxy
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 14) {
                MainActiveSection()
                MainPopularSection()
                MainArticlesView()
            }.padding(.bottom, 140)
        }
        .padding()
        .frame(width: geometry.size.width, height: geometry.size.height * 0.768)
        .background(Color("mainBgColor"))
        .cornerRadius(37)
    }
}
