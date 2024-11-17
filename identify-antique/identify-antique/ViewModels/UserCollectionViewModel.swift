import Foundation

final class UserCollectionViewModel: ObservableObject {
    @Published var collections: [Collection] = []
    
    ///Creates new collection with name
    func addCollection(name: String){
        guard !name.isEmpty else {return}
        let newCollection = Collection(name: name)
        collections.append(newCollection)
    }
}
