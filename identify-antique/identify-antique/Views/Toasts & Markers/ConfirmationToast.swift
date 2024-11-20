import SwiftUI

struct ConfirmationToast: View {
    let text: String
    var body: some View {
        HStack(spacing: 12) {
            Image("tickWhite")
            Text(text).font(.system(size: 16, weight: .medium)).foregroundStyle(.white)
        }
        .padding(.horizontal,20)
        .frame(height: 50)
        .background(Color("accentGreen"))
        .cornerRadius(25)
    }
}

#Preview {
    ConfirmationToast(text: "New collection added")
}
