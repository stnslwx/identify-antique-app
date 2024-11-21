import SwiftUI

struct ResultItemView: View {
    
    @ObservedObject private var collectionVm = UserCollectionViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    let isConfirmationalView: Bool
    let similarItems: [Int] = [1,2,3,4,5]
    
    @Binding var openScanner: Bool
    
    @State private var isSavinInCollectionSheetPresented: Bool = false
    @State private var isCreateCollectionSheetPresented: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    VStack(spacing: 16) {
                        CollItemTopBar(
                            itemName: "Hoff Sofa",
                            isConfirmational: isConfirmationalView,
                            openScanner: $openScanner,
                            navAction: {presentationMode.wrappedValue.dismiss()},
                            addAction: {isSavinInCollectionSheetPresented = true},
                            closeAction: {openScanner = false})
                        ItemImageView()
                        ItemStatistics(geometry: geometry)
                        AILabels()
                        OtherItemInformation()
                    }.padding(.horizontal, 20)
                    SimilarItems(geometry: geometry, items: similarItems)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("mainBgColor"))
        }.navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isSavinInCollectionSheetPresented){
                isSavinInCollectionSheetPresented = false
            } content: {
                SaveInCollectionSheet(collectionsVm: collectionVm)
                    .presentationDetents([.fraction(0.85)])
            }
    }
    
    // Title & buttons
    struct CollItemTopBar: View {
        
        let itemName: String
        let isConfirmational: Bool
        
        @Binding var openScanner: Bool
        
        let navAction: () -> Void
        let addAction: () -> Void
        let closeAction: () -> Void
        
        var body: some View {
            HStack {
                ItemInfoButton(action: navAction, icon: "arrowLeft", isSecondary: true)
                Spacer()
                Text(itemName).font(.system(size: 20, weight: .bold))
                Spacer()
                if isConfirmational {
                    ItemInfoButton(action: closeAction, icon: "tick", isSecondary: false)
                } else {
                    ItemInfoButton(action: addAction, icon: "plus", isSecondary: false)
                }
            }.frame(maxWidth: .infinity)
        }
    }
    
    //Image
    struct ItemImageView: View {
        var body: some View {
            VStack {
                Image("collectionItemPrev")
                    .resizable()
                    .frame(maxWidth: .infinity).frame(height: 200)
                    .cornerRadius(24)
            }
        }
    }
    
    //Price & Rating
    struct ItemStatistics: View {
        let geometry: GeometryProxy
        var body: some View {
            HStack {
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        Text("avg. price").font(.system(size: 13))
                        Text("$540-980").font(.system(size: 19)).bold()
                    }
                    Spacer()
                }
                .padding()
                .frame(width: geometry.size.width/2 - 30, height: 65)
                .background(.white)
                .cornerRadius(17)
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Rating").font(.system(size: 13))
                        Text("4.9").font(.system(size: 19)).bold()
                    }
                    Spacer()
                }
                .padding()
                .frame(width: geometry.size.width/2 - 30, height: 65)
                .background(.white)
                .cornerRadius(17)
            }
        }
    }
    
    //Items AI Labels
    struct AILabels: View {
        let labels = ["Telephone", "1902", "Black"]
        var body: some View {
            
            VStack(spacing: 16) {
                
                VStack(spacing: 10) {
                    HStack {
                        Text("AI Labels").font(.system(size: 14, weight: .light))
                        Spacer()
                    }
                    
                    VStack{}.frame(maxWidth: .infinity).frame(height: 1).background(Color("tabGrey"))
                }
                
                HStack {
                    ForEach(labels, id:\.self) { label in
                        Text(label)
                            .font(.system(size: 15, weight: .bold))
                            .padding(.horizontal, 20).padding(.vertical, 6)
                            .background(Color("mainBgColor")).cornerRadius(43)
                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 110)
            .background(RoundedRectangle(cornerRadius: 17).fill(.white))
            
        }
    }
    
    // Item info articles
    struct OtherItemInformation: View {
        private let info = CollectionItemInfo().itemFacts
        var body: some View {
            VStack(spacing: 16) {
                ForEach(info, id: \.id) { infoItem in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(infoItem.title).font(.system(size: 16, weight: .bold))
                        Text(infoItem.text).font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity).frame(minWidth: 180)
                    .background(.white).cornerRadius(17)
                }
            }
        }
    }
    
    struct SimilarItems: View {
        let geometry: GeometryProxy
        let items: [Int]
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Text("Similar").font(.system(size: 18, weight: .bold))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(items, id:\.self) { item in
                            VStack(alignment: .leading) {
                                Image("")
                                    .frame(width: geometry.size.width/2 - 30, height: 190)
                                    .background(Color("similarItemsBg"))
                                    .cornerRadius(14)
                                VStack(alignment: .leading) {
                                    Text("Telephone").font(.system(size: 15, weight: .bold))
                                    Text("easypub.en").font(.system(size: 15, weight: .light)).foregroundStyle(Color("itemInfoGray"))
                                }.padding(.leading, 10)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 20).padding(.top, 15)
        }
    }
}
