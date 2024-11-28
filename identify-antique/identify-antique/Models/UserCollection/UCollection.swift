import Foundation

struct UCollection: Identifiable {
    let id = UUID()
    let name: String
    let items: [UCItem]
}
