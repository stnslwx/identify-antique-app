import Foundation

final class CollectionSheetModel: ObservableObject {
    
    @Published var isCreateCollPresent: Bool = false
    @Published var isCreateCollFromItemViewPresented: Bool = false
    @Published var isInsideCollPresented: Bool = false
    @Published var saveInCollPresented: Bool = false
    @Published var saveInCollFromScannerPresented: Bool = false
    @Published var isArticleViewPresented: Bool = false
    
    @Published var isCreatingCollFromItem: Bool = false
    @Published var showInfo: Bool = false
}
