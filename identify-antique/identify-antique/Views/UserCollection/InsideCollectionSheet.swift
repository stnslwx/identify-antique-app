import SwiftUI

struct InsideCollectionSheet: View {
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        GeometryReader { geometry in
            VStack(spacing: 20) {
                
                VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                
                HStack {
                    Spacer()
                    Text("Name").font(.system(size: 18, weight: .bold))
                    Spacer()
                    TrippleDotsButton(action: {print("tripple dots button inside collection")})
                }
                
                LazyVGrid(columns: columns) {
                   InsideCollectionItem(geometry: geometry)
                }
                
                Spacer()
                
            }.padding(.horizontal, 20).padding(.top, 15)
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
        var body: some View {
            VStack {
                
            }
            .frame(width: geometry.size.width/2 - 27, height: geometry.size.width/2 - 27)
            .background(Color("collectionSegmentBg"))
            .cornerRadius(23)
        }
    }
}

#Preview {
    InsideCollectionSheet()
}
