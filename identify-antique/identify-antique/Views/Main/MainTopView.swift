import SwiftUI

struct MainTopView: View {
    @Binding var isMenuPresented: Bool
    let geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                MainTopButton(name: "info", action: {print("info")})
                Spacer()
                MainTopButton(name: "settings", action: {isMenuPresented = true})
            }.padding(.top, 5)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    MainViewInterfacePlan(planType: "Base Plan")
                    Text("Antique Identifier")
                        .foregroundStyle(.white)
                        .font(.title).bold()
                }
                Spacer()
            }
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
