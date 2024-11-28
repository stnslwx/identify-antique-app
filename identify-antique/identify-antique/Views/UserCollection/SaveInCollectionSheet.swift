import SwiftUI

struct SaveInCollectionSheet: View {
    
    @ObservedObject var collectionsVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        GeometryReader { geometry in

            VStack(alignment: .center,spacing: 20) {
                
                VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                
                Text("Save in").font(.system(size: 18, weight: .bold))
                                
                CollectionsListView(collectionsVm: collectionsVm, collectionSheetsModel: collectionSheetModel, isSaving: true)
                
                Spacer()
                SaveButton(action: {
                    print("save item in collection")
                    collectionSheetModel.saveInCollPresented = false
                    collectionsVm.saveItemInCollection()
                }, isSelected: collectionsVm.selectedCollForSaving != nil)
                
            }
            .padding(.horizontal, 20).padding(.top, 15)
            .frame(width: geometry.size.width)
        }
    }
    
    struct SaveButton: View {
        let action: () -> Void
        var isSelected: Bool
        var body: some View {
            Button(action:action){
                VStack {
                    Text("Save").font(.system(size: 16, weight: .medium)).foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity).frame(height: 60)
                .background(Color("accentGreen"))
                .overlay(alignment: .center, content: {
                    if !isSelected {
                        Color(#colorLiteral(red: 0.8374214172, green: 0.8374213576, blue: 0.8374213576, alpha: 0.6)).frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                })
                .cornerRadius(34)
            }
            .disabled(!isSelected)
            .padding(.bottom, 10)
        }
    }
}
