import SwiftUI

struct FullArticleView: View {
    
    @ObservedObject var sheetModel: CollectionSheetModel
    
    @State private var startingOffset: CGFloat = 0.15
    @State private var currentDragOffset: CGFloat = 0.0
    @State private var endingOffset: CGFloat = 0.0
    
    let maxDragOffset: CGFloat = 120
    let minDragOffset: CGFloat = -120

    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    VStack {
                        HStack {
                            Button(action: {
                                sheetModel.isArticleViewPresented = false
                            }) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("articleBtnColor"))
                                    .overlay(alignment: .center) {
                                        Image("arrowArticle")
                                            
                                    }
                                    .frame(width: 40, height: 40)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    .background{
                        Image("articleBg").resizable().scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                    }
                    Spacer()
                }
                VStack(spacing: 20) {
                    VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                    
                    Text(ArticleText.title).font(.system(size: 22, weight: .bold)).multilineTextAlignment(.center).padding(.horizontal, 30)
                    
                    Text(ArticleText.text).font(.system(size: 16)).lineSpacing(7)
                    
                    Spacer()
                }
                .padding(.horizontal).padding(.top, 12)
                .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                .background(.white)
                .cornerRadius(23)
                .offset(y: geometry.size.height * startingOffset)
                .offset(y: currentDragOffset)
                .offset(y: geometry.size.height * endingOffset)

                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            let newOffset = value.translation.height
                                    
                            if newOffset < minDragOffset || newOffset > maxDragOffset {
                                return 
                            }
                            
                            withAnimation(.spring()) {
                                currentDragOffset = newOffset
                            }
                            
                        }
                    
                        .onEnded { value in
                            
                            withAnimation(.spring()) {
                                if currentDragOffset < 85 {
                                    endingOffset = -startingOffset
                                    currentDragOffset = 0
                                } else if endingOffset != 0 && currentDragOffset > 85 {
                                    endingOffset = 0
                                    currentDragOffset = 0
                                } else {
                                    currentDragOffset = 0
                                }
                            }
                        }
                )
            }
        }
    }
}
