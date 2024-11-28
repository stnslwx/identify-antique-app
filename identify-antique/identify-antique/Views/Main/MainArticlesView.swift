import SwiftUI

struct MainArticlesView: View {
    
    @ObservedObject var sheetModel: CollectionSheetModel
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(MainScreenArticles().articles) { article in
                ArticleView(title: article.title, text: article.text, image: article.image, action: {
                    sheetModel.isArticleViewPresented = true
                })
            }
        }
    }
    
    struct ArticleView: View {
        let title: String
        let text: String
        let image: String
        let action: () -> Void
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 16){
                    Text(title).font(.system(size: 16, weight: .bold, design: .default)).lineLimit(2)
                    Text(text).font(.system(size: 10, weight: .regular, design: .default)).lineLimit(2) .multilineTextAlignment(.leading)
                    Button(action: action, label: {
                        Text("Read More").foregroundStyle(Color("accentGreen")).font(.system(size: 15, weight: .regular, design: .default))
                    })
                }
                .frame(maxWidth: .infinity)
                Spacer()
                Image("article")
            }
            .padding(.leading, 30)
            .background(Color("transparentGreen"))
            .cornerRadius(23)
        }
    }
}
