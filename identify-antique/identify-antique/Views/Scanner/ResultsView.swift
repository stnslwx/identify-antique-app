import SwiftUI

struct ResultsView: View {
    
    @Binding var isLoading: Bool
    @Binding var navigate: Bool
    
    let geometry: GeometryProxy
    
    let items = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20).padding(.bottom, 25)
            
            if isLoading {
                LoadingWithText()
            } else {
                SimilarResults(items: items, geometry: geometry)
            }

        }
        .padding(.horizontal, 20).padding(.vertical, 8)
        .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
        .background(.white)
        .cornerRadius(23)
        .overlay(alignment: .top) {
            if !isLoading {
                ViewResultBtn(action: {navigate = true})
                .offset(y: -80)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                isLoading = false
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
                    Text("View Results").font(.system(size: 17, weight: .bold))
                }
                .frame(width: 280, height: 60)
                .background(.white)
                .cornerRadius(69)
            }
        }
    }
    
    struct SimilarResults: View {
        let items: [Int]
        let geometry: GeometryProxy
        var body: some View {
            
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: columns) {
                    ForEach(items.indices, id: \.self) { index in
                        
                        let item = items[index]
                        let order = Int(index + 1)
                        let specialPositions = getSpecialPositions(count: items.count)
                        
                        VStack(alignment: .leading) {
                            Image("article")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width/2 - 30,
                                       height: specialPositions.contains(order) ? 130 : 190)
                                .background(Color("similarItemsBg"))
                                .cornerRadius(14)
                            VStack(alignment: .leading) {
                                Text("Telephone \(item)").font(.system(size: 15, weight: .bold))
                                Text("easypub.en").font(.system(size: 15, weight: .light)).foregroundStyle(Color("itemInfoGray"))
                            }.padding(.leading, 10)
                            
                            if specialPositions.contains(order) {
                                Spacer()
                            }
                        }
                        
                    }
                }
                
            }
            
        }
        
        func getSpecialPositions(count: Int) -> [Int] {
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
