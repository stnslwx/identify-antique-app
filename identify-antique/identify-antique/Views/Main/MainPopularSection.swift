import SwiftUI

struct MainPopularSection: View {
    @Binding var openScanner: Bool
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
       
    var body: some View {
        VStack {
            HStack {
                Text("Popular").font(.system(size: 24, weight: .bold, design: .default))
                Spacer()
            }.padding(.leading, 30)
            LazyVGrid(columns: columns, spacing: 22) {
                ForEach(MainScreenPopular().popularItems) { item in
                    VStack {
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background{
                                Circle().fill((Color.gray.opacity(0.2)))
                                    .frame(width: 80, height: 80)
                            }.frame(width: 80,height: 80)
                        
                        Text(item.name)
                            .font(.system(size: 19, weight: .medium, design: .default))
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        openScanner = true
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 30)
        .padding(.top, 15)
        .background(.white)
        .cornerRadius(23)
    }
}
