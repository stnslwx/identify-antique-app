import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let image: String
}
