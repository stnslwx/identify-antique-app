import Foundation

final class UserCollectionViewModel: ObservableObject {
    @Published var collections: [Collection] = []
    @Published var selectedCollection: Collection?
    @Published var selectedItem: CollectionItem?
    @Published var selectedCollForSaving: Collection?
    @Published var itemSaved: Bool = false
    @Published var showToast: Bool = false
    @Published var showToastSaved: Bool = false
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func saveCollections() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(collections)
            let fileURL = getDocumentsDirectory().appendingPathComponent("collections.json")
            try data.write(to: fileURL)
            print("Collections saved to \(fileURL)")
        } catch {
            print("Error saving collections: \(error)")
        }
    }
    
    private func loadCollections() {
        let decoder = JSONDecoder()
        let fileURL = getDocumentsDirectory().appendingPathComponent("collections.json")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                collections = try decoder.decode([Collection].self, from: data)
                print("Collections loaded from \(fileURL)")
            } catch {
                print("Error loading collections: \(error)")
            }
        } else {
            print("No collections file found, starting with empty collections.")
        }
    }
    
    ///Создает новую коллекцию с именем и отображает тост
    func addCollection(name: String) {
        guard !name.isEmpty else { return }
        let newCollection = Collection(name: name, items: [])
        collections.append(newCollection)
        DispatchQueue.global(qos: .background).async {
            self.saveCollections()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showToast = false
            }
        }
        print("Collection: \(name) added: \(newCollection)")
    }
    
    ///Сохраняет новый элемент в коллекцию
    func saveItemInCollection() {
        guard let collToSaveIn = selectedCollForSaving, let item = selectedItem else {
            print("Collection or Item is nil while saving")
            return
        }
        DispatchQueue.global(qos: .background).async {
            if let index = self.collections.firstIndex(where: {$0.id == collToSaveIn.id}) {
                self.collections[index].items.append(item)
                self.saveCollections()
            } else {
                print("coll not found")
            }
        }
        itemSaved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showToastSaved = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showToastSaved = false
            }
        }
    }
    
    ///Удаляет коллекцию
    func deleteCollection() {
        guard let selectedCollection = selectedCollection else {
            print("Error deleting collection")
            return
        }
        
        if let index = collections.firstIndex(where: { $0.id == selectedCollection.id }) {
            collections.remove(at: index)
            saveCollections() // Сохраняем после удаления коллекции
            print("Collection \(selectedCollection.name) removed from collections")
        }
    }
    
    ///Сбрасывает переменные
    func closeItemInfoAction() {
        self.selectedItem = nil
        self.selectedCollForSaving = nil
    }
    
    init() {
        loadCollections()
    }
}
