import SwiftUI

struct UserCollectionView: View {
    @State private var selectedOption: ViewOption = .collection
    @State private var isCollectionEmpty: Bool = true
    
    @Binding var isCreateCollectionPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CustomPicker(selectedOption: $selectedOption)
                UserCollectionStatistics(antiqueCount: 0, coutriesCount: 0, collectionsCount: 0)
                if selectedOption == .collection {
                    if isCollectionEmpty {
                        EmptyCollectionView(isCreateCollectionPresented: $isCreateCollectionPresented)
                            .padding(.top, 120)
                    }
                } else {
                    Text("HISTORY")
                }
                Spacer()
            }
            .padding(.horizontal, 30).padding(.bottom, geometry.size.height * 0.11)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("mainBgColor"))
        }
    }
    
    struct EmptyCollectionView: View {
        @Binding var isCreateCollectionPresented: Bool
        var body: some View {
            VStack(spacing: 21) {
                VStack(spacing: -5)  {
                    Image("emptyCollection")
                    Text("It's empty here yet").foregroundStyle(Color(#colorLiteral(red: 0.1607843339, green: 0.1607843339, blue: 0.1607843339, alpha: 0.35)))
                }
                Button(action: {isCreateCollectionPresented = true}){
                    VStack {
                        Text("Add colllection").font(.system(size: 16, weight: .bold, design: .default)).foregroundStyle(.black)
                    }
                    .frame(width: 200, height: 49)
                    .background(.white)
                    .cornerRadius(29)
                }
            }
        }
    }
}
#Preview {
    UserCollectionView(isCreateCollectionPresented: .constant(false))
}

