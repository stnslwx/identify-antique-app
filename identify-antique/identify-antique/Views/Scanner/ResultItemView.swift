import SwiftUI

struct ResultItemView: View {
    
    @ObservedObject var collectionVm: UserCollectionViewModel
    @ObservedObject var collectionSheetModel: CollectionSheetModel
    @ObservedObject var scanner: ScannerViewModel
    @ObservedObject var scanResult: ScanResultModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let similarItems: [Int] = [1,2,3,4,5]
    
    @Binding var openScanner: Bool
    
    @State private var isSavinInCollectionSheetPresented: Bool = false
    @State private var isCreateCollectionSheetPresented: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                if let scanData = scanResult.scanData {
                    VStack(spacing: 16) {
                        VStack(spacing: 16) {
                            CollItemTopBar(
                                itemName: scanData.gptResult.title,
                                itemSaved: collectionVm.itemSaved,
                                openScanner: $openScanner,
                                navAction: {
                                    presentationMode.wrappedValue.dismiss()
                                    collectionVm.itemSaved = false
                                    print("nav action")
                                },
                                addAction: {
                                    collectionSheetModel.saveInCollPresented = true
                                    if let image = scanner.capturedPhoto {
                                        collectionVm.selectedItem = CollectionItem(
                                            name: scanData.gptResult.title,
                                            image: image,
                                            gptResult: scanData.gptResult,
                                            itemResult: scanData.itemResult
                                        )
                                    }
                                },
                                closeAction: {
                                    openScanner = false
                                    collectionVm.itemSaved = false
                                    collectionVm.closeItemInfoAction()
                                    print("close action")

                                })
                                .zIndex(10)
                            if let image = scanner.capturedPhoto {
                                ItemImageView(image: image)
                            }
                            ItemStatistics(geometry: geometry, price: scanData.gptResult.price)
                            AILabels(labels: scanData.gptResult.label)
                            OtherItemInformation(didYouKnow: scanData.gptResult.didYouKnow, facts: scanData.gptResult.description)
                        }.padding(.horizontal, 20)
                        SimilarItems(geometry: geometry, items: scanData.itemResult)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("mainBgColor"))
            .overlay(alignment: .bottom) {
                ConfirmationToast(text: "Successfully saved")
                    .offset(y: collectionVm.showToastSaved ? -50 : 100)
                    .animation(.easeInOut(duration: 0.5), value: collectionVm.showToastSaved)
            }
        }.navigationBarBackButtonHidden(true)
        .sheet(isPresented: $collectionSheetModel.saveInCollPresented){
            collectionSheetModel.saveInCollPresented = false
            collectionVm.selectedCollForSaving = nil
            if collectionSheetModel.isCreatingCollFromItem {
                collectionSheetModel.isCreateCollFromItemViewPresented = true
            }
        } content: {
            SaveInCollectionSheet(collectionsVm: collectionVm, collectionSheetModel: collectionSheetModel)
                .presentationDetents([.fraction(0.85)])
        }
        .sheet(isPresented: $collectionSheetModel.isCreateCollFromItemViewPresented){
            collectionSheetModel.isCreateCollFromItemViewPresented = false
            collectionSheetModel.isCreatingCollFromItem = false
            collectionSheetModel.saveInCollPresented = true
        } content: {
            CreateCollectionSheet(collectionVm: collectionVm, collectioSheetsModel: collectionSheetModel, isSaving: true)
                .presentationDetents([.fraction(0.7)])
        }
    }
    
    // Title & buttons
    struct CollItemTopBar: View {
        
        let itemName: String
        let itemSaved: Bool
        
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
                if itemSaved {
                    ItemInfoButton(action: closeAction, icon: "tick", isSecondary: false)
                } else {
                    ItemInfoButton(action: addAction, icon: "plus", isSecondary: false)
                }
            }.frame(maxWidth: .infinity)
        }
    }
    
    //Image
    struct ItemImageView: View {
        let image: UIImage
        var body: some View {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity).frame(height: 200)
                    .cornerRadius(24)
                    .clipped()
            }
        }
    }
    
    //Price & Rating
    struct ItemStatistics: View {
        let geometry: GeometryProxy
        let price: String
        var body: some View {
            HStack {
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Avg. price").font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
                        Text(price).font(.system(size: 19)).bold()
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
                        Text("Rating").font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
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
        let labels: [String]
        var body: some View {
            
            VStack(spacing: 16) {
                VStack(spacing: 10) {
                    
                    HStack {
                        Text("AI Labels").font(.system(size: 14, weight: .light))
                        Spacer()
                    }
                    
                    VStack{}.frame(maxWidth: .infinity).frame(height: 1).background(Color("tabGrey"))
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(labels, id:\.self) { label in
                            Text(label)
                                .font(.system(size: 15, weight: .bold))
                                .padding(.horizontal, 20).padding(.vertical, 6)
                                .background(Color("mainBgColor")).cornerRadius(43)
                        }
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
//        private let info = CollectionItemInfo().itemFacts
        let didYouKnow: String
        let facts: String
        var body: some View {
            VStack(spacing: 16) {
//                ForEach(info, id: \.id) { infoItem in
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Did you know?").font(.system(size: 16, weight: .bold))
//                        Text(didYouKnow).font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity).frame(minWidth: 180)
//                    .background(.white).cornerRadius(17)
//                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Did you know?").font(.system(size: 16, weight: .bold))
                    Text(didYouKnow).font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
                }
                .padding()
                .frame(maxWidth: .infinity).frame(minWidth: 180)
                .background(.white).cornerRadius(17)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Interesting Facts").font(.system(size: 16, weight: .bold))
                    Text(facts).font(.system(size: 13)).foregroundStyle(Color("itemInfoGray"))
                }
                .padding()
                .frame(maxWidth: .infinity).frame(minWidth: 180)
                .background(.white).cornerRadius(17)
            }
        }
    }
    
    struct SimilarItems: View {
        let geometry: GeometryProxy
        let items: [ItemResult]
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                Text("Similar").font(.system(size: 18, weight: .bold))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(items.indices, id:\.self) { index in
                            let item = items[index]
                            Link(destination: URL(string: item.link)!) {
                                VStack(alignment: .leading){
                                    AsyncImage(url: URL(string: item.imageUrl)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .cornerRadius(14)
                                                .frame(width: geometry.size.width/2 - 30, height: 190)
                                                .background(Color("similarItemsBg"))
                                                .clipped()
                                        case .failure:
                                            Image("article")
                                                .resizable()
                                                .scaledToFill()
                                                .cornerRadius(14)
                                                .frame(width: geometry.size.width/2 - 30, height: 190)
                                                .background(Color("similarItemsBg"))
                                                .clipped()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: geometry.size.width/2 - 30, height: 190)
                                    .background(Color("similarItemsBg"))
                                    .cornerRadius(14)
                                    VStack(alignment: .leading) {
                                        Text(item.title).font(.system(size: 15, weight: .bold)).lineLimit(1).foregroundColor(.black)
                                        Text(item.source).font(.system(size: 15, weight: .light)).foregroundStyle(Color("itemInfoGray")).lineLimit(1)
                                    }
                                    .padding(.leading, 10)
                                    .frame(width: geometry.size.width/2 - 30)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.leading, 20).padding(.top, 15)
        }
    }
}
