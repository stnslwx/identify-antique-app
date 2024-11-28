import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var scanModel: ScanResultModel
    @Binding var navigate: Bool
    
    let geometry: GeometryProxy
    
    let items = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20).padding(.bottom, 25)
            
            
            if scanModel.requestStatus == .loading {
                LoadingWithText()
            } else if scanModel.requestStatus == .success {
                SimilarResults(scanModel: scanModel, items: items, geometry: geometry)
            }

        }
        .padding(.horizontal, 20).padding(.vertical, 8)
        .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
        .background(.white)
        .cornerRadius(23)
        .overlay(alignment: .top) {
            if scanModel.requestStatus == .success {
                ViewResultBtn(action: {navigate = true})
                .offset(y: -80)
            }
        }
    }
    
    struct LoadingWithText: View {
        var body: some View {
            VStack(spacing: 20) {
                LoadingAnimation()
                Text("Loading..").font(.system(size: 17, weight: .medium))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct ViewResultBtn: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                VStack {
                    Text("View Results").font(.system(size: 17, weight: .bold)).foregroundStyle(.black)
                }
                .frame(width: 280, height: 60)
                .background(.white)
                .cornerRadius(69)
            }
        }
    }
    
    struct SimilarResults: View {
        @ObservedObject var scanModel: ScanResultModel

        let items: [Int]
        let geometry: GeometryProxy
        var body: some View {
            
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if let scanData = scanModel.scanData {
                    LazyVGrid(columns: columns) {
                        ForEach(scanData.itemResult.indices, id:\.self) { index in
                            let item = scanData.itemResult[index]
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
                                                .frame(width: geometry.size.width/2 - 30, height: 130)
                                                .background(Color("similarItemsBg"))
                                                .clipped()
                                        case .failure:
                                            Image("article")
                                                .resizable()
                                                .scaledToFill()
                                                .cornerRadius(14)
                                                .frame(width: geometry.size.width/2 - 30, height: 130)
                                                .background(Color("similarItemsBg"))
                                                .clipped()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: geometry.size.width/2 - 30, height: 130)
                                    .background(Color("similarItemsBg"))
                                    .cornerRadius(14)
                                    VStack(alignment: .leading) {
                                        Text(item.title).font(.system(size: 15, weight: .bold)).lineLimit(1).foregroundColor(.black)
                                        Text(item.source).font(.system(size: 15, weight: .light)).foregroundStyle(Color("itemInfoGray")).lineLimit(1)
                                    }.padding(.leading, 10)
                                }
                            }
                        }
                    }
                
                }
                
//                LazyVGrid(columns: columns) {
//                    ForEach(items.indices, id: \.self) { index in
//                        
//                        let item = items[index]
//                        let order = Int(index + 1)
//                        let specialPositions = getSpecialPositions(count: items.count)
//                        
//                        VStack(alignment: .leading) {
//                            Image("article")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width/2 - 30, height: 190)
//                                .background(Color("similarItemsBg"))
//                                .cornerRadius(14)
//                            VStack(alignment: .leading) {
//                                Text("Telephone \(item)").font(.system(size: 15, weight: .bold))
//                                Text("easypub.en").font(.system(size: 15, weight: .light)).foregroundStyle(Color("itemInfoGray"))
//                            }.padding(.leading, 10)
//                            
//                            if specialPositions.contains(order) {
//                                Spacer()
//                            }
//                        }
//                        
//                    }
//                }
                
            }
            
        }
        
        func getSpecialPositions(count: Int) -> [Int] {
            //specialPositions.contains(order) ? 130 :
            var positions = [Int]()
            
            var i = 1
            while i <= count {
                positions.append(i)  // Добавляем текущий элемент
                i += 3  // Перемещаемся на 3 шага вперед
                
                if i <= count {
                    positions.append(i)  // Добавляем следующий элемент через 1 шаг
                    i += 1  // Перемещаемся на 1 шаг вперед
                }
            }
            
            return positions
        }
        
    }
}
