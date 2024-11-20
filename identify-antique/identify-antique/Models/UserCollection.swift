import Foundation

struct CollectionItem: Identifiable {
    let id = UUID()
    var name: String
}

struct Collection: Identifiable {
    let id = UUID()
    var name: String
    var items: [CollectionItem] = []
}
