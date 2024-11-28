//Displaying all users collections

import SwiftUI

struct CollectionsListView: View {
    
    @ObservedObject var collectionsVm: UserCollectionViewModel
    @ObservedObject var collectionSheetsModel: CollectionSheetModel
    
    var isSaving: Bool

    var body: some View {
        GeometryReader { geometry in
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            if collectionsVm.collections.count < 5{
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(collectionsVm.collections, id:\.id) { collection in
                        CollectionDisplay(geometry: geometry, name: collection.name, isSaving: isSaving,
                                          selectedColl: collectionsVm.selectedCollForSaving, currentColl: collection)
                            .onTapGesture {
                                if isSaving {
                                    collectionsVm.selectedCollForSaving = collection
                                } else {
                                    collectionsVm.selectedCollection = collection
                                    collectionSheetsModel.isInsideCollPresented = true
                                }
                            }
                    }
                    AddCollectionInsideButton(geometry: geometry, action: {
                        if isSaving {
                            collectionSheetsModel.saveInCollPresented = false
                            collectionSheetsModel.isCreatingCollFromItem = true
                        } else {
                            collectionSheetsModel.isCreateCollPresent = true

                        }
                    })
                }.frame(width: geometry.size.width)
                
            } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(collectionsVm.collections, id:\.id) { collection in
                            CollectionDisplay(geometry: geometry, name: collection.name, isSaving: isSaving,
                                              selectedColl: collectionsVm.selectedCollForSaving, currentColl: collection)
                                .onTapGesture {
                                    if isSaving {
                                        collectionsVm.selectedCollForSaving = collection
                                    } else {
                                        collectionsVm.selectedCollection = collection
                                        collectionSheetsModel.isInsideCollPresented = true
                                    }
                                }
                        }
                        AddCollectionInsideButton(geometry: geometry, action: {
                            if isSaving {
                                collectionSheetsModel.saveInCollPresented = false
                                collectionSheetsModel.isCreatingCollFromItem = true
                            } else {
                                collectionSheetsModel.isCreateCollPresent = true

                            }
                        })
                    }.frame(width: geometry.size.width)
                }
                
            }
        }
    }
    
    struct CollectionDisplay: View {
        //let collectionItems: [CollectionItem]

        let geometry: GeometryProxy
        let name: String
        let items = [1]
        
        let isSaving: Bool
        var selectedColl: Collection?
        var currentColl: Collection
        
        var body: some View {
            let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
            VStack(spacing: 10){
                LazyVGrid(columns: columns, spacing: 0){
                    if currentColl.items.count < 3 {
                        ForEach(currentColl.items.indices.prefix(4), id: \.self) { index in
                            let item = currentColl.items[index]
                            VStack {
                                Image(uiImage: item.getImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width/4 - 3, height: geometry.size.width/4)
                                    .clipped()
                            }
                        }
                        ForEach(0..<2) { _ in
                            VStack {
                                   RoundedRectangle(cornerRadius: 0).fill(Color.clear) // Прозрачные ячейки для заполнения
                                       .frame(width: geometry.size.width/4, height: geometry.size.width/4)
                                       //.frame(width: 50, height: 50)
                               }
                        }
                    } else {
                        ForEach(currentColl.items.indices.prefix(4), id: \.self) { index in
                            let item = currentColl.items[index]
                            VStack {
                                Image(uiImage: item.getImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width/4, height: geometry.size.width/4)
                                    .clipped()
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width/2 - 5, height: geometry.size.width/2 - 5)
                .background(Color("collectionSegmentBg"))
                .cornerRadius(23)
                .overlay(alignment: .center) {
                    CDSegmentationOverlay(geometry: geometry)
                        .overlay(alignment: .center) {
                            if isSaving {
                                if let selectedColl = selectedColl {
                                    if selectedColl.id == currentColl.id {
                                        Circle().fill(Color("accentGreen")).frame(width: 54, height: 54)
                                            .overlay(alignment: .center) {Image("tickWhite").resizable().frame(width: 17, height: 13)}
                                    }
                                }
                            }
                        }
                }
                Text(name).font(.system(size: 17, weight: .bold)).lineLimit(1).truncationMode(.tail).minimumScaleFactor(0.5)
            }
        }
        struct CDSegmentationOverlay: View {
            let geometry: GeometryProxy
            var body: some View {
                VStack {}
                    .frame(width: 2, height: geometry.size.width/2 - 5)
                    .background(.white)
                    .overlay(alignment: .center) {
                        VStack{}
                            .frame(width: geometry.size.width/2 - 5, height: 2)
                            .background(.white)
                    }
            }
        }
    }

    struct AddCollectionInsideButton: View {
        let geometry: GeometryProxy
        let action: ()->Void
        var body: some View {
            VStack{
                Button(action: action, label: {
                    Circle().fill(Color("collectionSegmentBg")).frame(width: 48, height: 48)
                        .overlay(alignment: .center) {
                            Image(systemName: "plus").resizable().scaledToFill().frame(width: 15, height: 15).foregroundStyle(Color(#colorLiteral(red: 0.4599522352, green: 0.4599521756, blue: 0.4599521756, alpha: 1)))
                        }
                })
            }
            .frame(width: geometry.size.width/2 - 30, height: geometry.size.width/2 - 30)
        }
    }

}

