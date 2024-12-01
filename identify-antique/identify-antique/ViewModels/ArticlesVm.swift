import Foundation

final class ArticlesVm: ObservableObject {
    @Published var selectedArticle: Article = MainScreenArticles().articles.first!
}
