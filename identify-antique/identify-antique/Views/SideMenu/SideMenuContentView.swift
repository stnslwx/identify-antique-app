import SwiftUI

struct SideMenuContentView: View {
    @Binding var presentSideMenu: Bool
    let bgColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 0.18)
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 60) {
                HStack {
                    Text("Settings").font(.system(size: 20, weight: .bold))
                    Spacer()
                    CloseMenuBtn(action: {presentSideMenu.toggle()}, bg: Color(bgColor))
                    
                }
                VStack(alignment: .leading, spacing: 40) {
                    Link(destination: URL(string: "https://doc-hosting.flycricket.io/antique-identifier-scan-privacy-policy/7699bd65-6ee2-4814-8493-8476066ff82f/privacy")!) {
                        Text("Privacy Policy")
                    }
                    Link(destination: URL(string: "https://doc-hosting.flycricket.io/antique-identifier-scan-terms-of-use/184f79fa-85ad-4452-a14f-a7200132bba9/terms")!) {
                        Text("Terms of Use")
                    }
                    Link(destination: URL(string: "https://telegra.ph/Support-11-28-4")!) {
                        Text("Contact Us")
                    }
                    Button {
                        IAPManager.shared.restorePurchases()
                    } label: {
                        Text("Restore subscription")
                    }
                }.foregroundStyle(.black)
            }.padding(.horizontal, 30).padding(.top, 50)
        }
    }
    
    struct CloseMenuBtn: View {
        let action: () -> Void
        let bg: Color
        var body: some View {
            Button(action: action, label: {
                VStack {
                    Image("arrowRight")
                }
                .frame(width: 40, height: 40)
                .background(bg)
                .cornerRadius(12)
            })
        }
    }
}
