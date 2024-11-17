import SwiftUI

struct CollectionItemView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    
                }
                ItemImageView()
                ItemStatistics(geometry: geometry)
            }
            .padding(.horizontal, 20)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("green"))
        }
    }
    
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
    
    struct ItemStatistics: View {
        let geometry: GeometryProxy
        var body: some View {
            HStack {
                
            }
            .frame(width: geometry.size.width/0.2 - 17)
            .background(.white)
            .cornerRadius(17)
            HStack {
                
            }
            .frame(width: geometry.size.width/0.2 - 17)
            .background(.white)
            .cornerRadius(17)
        }
    }
}

#Preview {
    CollectionItemView()
}
