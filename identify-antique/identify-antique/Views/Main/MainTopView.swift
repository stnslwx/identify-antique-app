import SwiftUI

struct MainTopView: View {
    @Binding var isMenuPresented: Bool
    let geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    MainViewInterfacePlan(planType: IAPManager.shared.isPurchased ? "Premium" : "Base Plan")
                    Text("Antique Identifier")
                        .foregroundStyle(.white)
                        .font(.title).bold()
                }
                Spacer()
            }.padding(.top, 60)
            Spacer()
        }
        .frame(height: geometry.size.height * 0.26)
        .padding(.horizontal)
        .background{
            Image("mainBg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.top)
                .offset(y: -5)
        }
        .onAppear {
            print(IAPManager.shared.isPurchased)
        }
    }
}

struct MainViewInterfacePlan: View {
    let planType: String
    var body: some View {
        Capsule()
            .fill(.ultraThinMaterial)
            .frame(width: 100, height: 27)
            .overlay(alignment: .center) {
                Text(planType)
                    .foregroundStyle(.white).font(.system(size: 16, weight: .medium, design: .default))
            }
    }
}
