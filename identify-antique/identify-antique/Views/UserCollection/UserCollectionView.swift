import SwiftUI

struct UserCollectionView: View {
    
    @ObservedObject var collectionVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
    @State private var selectedOption: ViewOption = .collection
    @State private var isCollectionEmpty: Bool = true
        
    let isSaving = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                CustomPicker(selectedOption: $selectedOption)
                UserCollectionStatistics(antiqueCount: 0, coutriesCount: 0, collectionsCount: collectionVm.collections.count)
                if selectedOption == .collection {
                    if collectionVm.collections.isEmpty {
                        EmptyCollectionView(collectionSheetModel: collectionSheetModel)
                            .padding(.top, 120)
                    } else {
                        CollectionsListView(collectionsVm: collectionVm, collectionSheetsModel: collectionSheetModel, isSaving: isSaving)
                    }
                } else {
                    //User history here
                }
                Spacer()
            }
            .padding(.horizontal, 30).padding(.bottom, geometry.size.height * 0.11)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("mainBgColor"))
            .overlay(alignment: .bottom) {
                ConfirmationToast(text: "New collection added")
                    .padding(.bottom, collectionVm.showToast ? 150 : 0)
                    .animation(.easeInOut(duration: 1), value: collectionVm.showToast)
            }
        }
    }
    
    struct EmptyCollectionView: View {
        @ObservedObject var collectionSheetModel: CollectionSheetModel

        var body: some View {
            VStack(spacing: 21) {
                VStack(spacing: -5)  {
                    Image("emptyCollection")
                    Text("It's empty here yet").foregroundStyle(Color(#colorLiteral(red: 0.1607843339, green: 0.1607843339, blue: 0.1607843339, alpha: 0.35)))
                }
                Button(action: {
                    //isCreateCollectionPresented = true
                    //collectionSheetModel.isPresented = true
                    collectionSheetModel.isCreateCollPresent = true
                }){
                    VStack {
                        Text("Add colllection").font(.system(size: 16, weight: .bold, design: .default)).foregroundStyle(.black)
                    }
                    .frame(width: 200, height: 49)
                    .background(.white)
                    .cornerRadius(29)
                }
            }
        }
    }
}

