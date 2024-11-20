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
                VStack(spacing: 40) {
                    Text("Privacy Policy")
                    Text("Terms of Use")
                    Text("Contact Us")
                    Text("Restore subscription")
                }
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
