import Foundation

// Элемент пользовательской коллекции
struct CollectionItem: Identifiable {
    let id = UUID()
    var name: String
}

// Коллекция
struct Collection: Identifiable {
    let id = UUID()
    var name: String
    var items: [CollectionItem] = []
}
