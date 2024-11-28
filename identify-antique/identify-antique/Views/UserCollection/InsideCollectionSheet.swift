import SwiftUI

struct InsideCollectionSheet: View {
    
    @ObservedObject var collectionsVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    
    //@Binding var showItemInfo: Bool
    
    @State private var showItemInfo: Bool = false
    @State private var showDeleteBtn: Bool = false
    
    var body: some View {
        let columns = [GridItem(.fixed(160)), GridItem(.fixed(160))]
        GeometryReader { geometry in
            VStack(spacing: 20) {
                
                VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                
                HStack {
                    Spacer()
                    if let selectedCollection = collectionsVm.selectedCollection {
                        Text(selectedCollection.name).font(.system(size: 18, weight: .bold))
                    }
                    Spacer()
                    TrippleDotsButton(action: {
                        showDeleteBtn.toggle()
                        print("tripple dots button inside collection")
                    })
                    .overlay(alignment: .trailing) {
                        if showDeleteBtn {
                            DeleteBtn(action: {
                                print("delete btn")
                                collectionSheetModel.isInsideCollPresented = false
                                collectionsVm.deleteCollection()
                            })
                                .zIndex(15)
                                .offset(y: 45)
                        }
                    }
                }
                .zIndex(10)
                
                LazyVGrid(columns: columns) {
                    if let selectedCollection = collectionsVm.selectedCollection {
                        ForEach(selectedCollection.items.indices, id: \.self) { index in
                            let item = selectedCollection.items[index]
                            InsideCollectionItem(geometry: geometry, name: item.name, image: item.getImage())
                                .frame(width: 160, height: 160)
                                .onTapGesture {
                                    collectionsVm.selectedItem = item
                                    //collectionSheetModel.isInsideCollPresented = false
                                    collectionSheetModel.showInfo = true
                                }
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
                
            }
            .padding(.horizontal, 20).padding(.top, 15)
        }
        .fullScreenCover(isPresented: $collectionSheetModel.showInfo) {
            collectionSheetModel.showInfo = false
        } content: {
            CollectionItemView(collectionVm: collectionsVm, collectionSheetModel: collectionSheetModel)
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
        let image: UIImage
        var body: some View {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipped()
                    .background(Color("collectionSegmentBg"))
                    .cornerRadius(23)
                    .contentShape(Rectangle()) 
            }
            .frame(width: 160, height: 160)
            .clipped()
        }
    }
    
    struct DeleteBtn: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 160, height: 50)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                    .overlay(alignment: .center) {
                        Text("Delete Collection").foregroundStyle(.black).font(.system(size: 18))
                    }
            }
        }
    }
}
