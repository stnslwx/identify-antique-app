//Displaying all users collections

import SwiftUI

struct CollectionsListView: View {
    
    @ObservedObject var collectionsVm: UserCollectionViewModel
    
    @Binding var isCreateCollectionPresented: Bool
    @Binding var isInsideCollectionPresented: Bool
    
    var isSaving: Bool

    var body: some View {
        GeometryReader { geometry in
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            if collectionsVm.collections.count < 5{
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(collectionsVm.collections, id:\.id) { collection in
                        CollectionDisplay(isInsideCollectionPresented: $isInsideCollectionPresented, geometry: geometry, name: collection.name)
                    }
                    AddCollectionInsideButton(geometry: geometry, action: {isCreateCollectionPresented = true})
                }.frame(width: geometry.size.width)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(collectionsVm.collections, id:\.id) { collection in
                            CollectionDisplay(isInsideCollectionPresented: $isInsideCollectionPresented, geometry: geometry, name: collection.name)
                        }
                        AddCollectionInsideButton(geometry: geometry, action: {isCreateCollectionPresented = true})
                    }.frame(width: geometry.size.width)
                }
            }
        }
    }
    
    struct CollectionDisplay: View {
        //let collectionItems: [CollectionItem]
        @Binding var isInsideCollectionPresented: Bool
        let geometry: GeometryProxy
        let name: String
        let items = [1,2,3]
        var body: some View {
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            VStack{
                LazyVGrid(columns: columns){
                    ForEach(Array(items).prefix(4), id:\.self) { item in
                        VStack{
                            Image("popular1")
                        }
                    }
                }
                .frame(width: geometry.size.width/2 - 5, height: geometry.size.width/2 - 5)
                .background(Color("collectionSegmentBg"))
                .cornerRadius(23)
                .overlay(alignment: .center) {
                    CDSegmentationOverlay(geometry: geometry)
                }
                .onTapGesture {
                    isInsideCollectionPresented = true
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
