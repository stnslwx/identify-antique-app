import SwiftUI

struct InsideCollectionSheet: View {
    
    @ObservedObject var collectionsVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
    //@Binding var showItemInfo: Bool
    
    @State private var showItemInfo: Bool = false
    
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        GeometryReader { geometry in
            VStack(spacing: 20) {
                
                VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                
                HStack {
                    Spacer()
                    Text(collectionsVm.selectedCollection!.name).font(.system(size: 18, weight: .bold))
                    Spacer()
                    TrippleDotsButton(action: {print("tripple dots button inside collection")})
                }
                
                LazyVGrid(columns: columns) {
                    if let selectedCollection = collectionsVm.selectedCollection {
                        ForEach(selectedCollection.items, id: \.id) { item in
                            InsideCollectionItem(geometry: geometry, name: item.name)
                                .onTapGesture {
                                    collectionsVm.selectedItem = item
                                    //collectionSheetModel.isInsideCollPresented = false
                                    showItemInfo = true
                                }
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 20).padding(.top, 15)
        }
        .fullScreenCover(isPresented: $showItemInfo) {
            showItemInfo = false
        } content: {
            CollectionItemView(collectionVm: collectionsVm, collectionSheetModel: collectionSheetModel, showInfo: $showItemInfo)
                .presentationDetents([.fraction(1)])
        }
    }
    
    struct TrippleDotsButton: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                Image("trippleDots")
            }
        }
    }
    
    struct InsideCollectionItem: View {
        let geometry: GeometryProxy
        let name: String
        var body: some View {
            VStack {
                Text(name)
            }
            .frame(width: geometry.size.width/2 - 27, height: geometry.size.width/2 - 27)
            .background(Color("collectionSegmentBg"))
            .cornerRadius(23)
        }
    }
}
