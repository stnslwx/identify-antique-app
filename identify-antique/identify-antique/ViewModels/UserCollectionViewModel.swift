import Foundation

final class UserCollectionViewModel: ObservableObject {
    @Published var collections: [Collection] = [
        Collection(name: "First", items: [CollectionItem(name: "First Item")])
    ]
    
    @Published var selectedCollection: Collection?
    @Published var selectedItem: CollectionItem?
    
    @Published var showToast: Bool = false
    
    ///Creates new collection with name, and allerts view with toast
    func addCollection(name: String){
        guard !name.isEmpty else {return}
        let newCollection = Collection(name: name)
        collections.append(newCollection)
        
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showToast = false
        }
        print("Collection: \(name) added: \(collections)")
    }
    
    func showConfirmationToast(){
        
    }
}
