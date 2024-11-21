import Foundation

final class CollectionSheetModel: ObservableObject {
    
    @Published var isCreateCollPresent: Bool = false
    @Published var isInsideCollPresented: Bool = false
    @Published var saveInCollPresented: Bool = false
}
