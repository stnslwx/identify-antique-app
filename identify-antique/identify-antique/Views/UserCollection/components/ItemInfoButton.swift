import SwiftUI

struct ItemInfoButton: View {
    let action: () -> Void
    let icon: String
    let isSecondary: Bool
    let secondaryColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 0.18)
    var body: some View {
        Button(action: action) {
            VStack {
                Image(icon)
            }
            .frame(width: 40, height: 40)
            .background(isSecondary ? Color(secondaryColor) : .white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    ItemInfoButton(action: {print("ItemInfoButton")}, icon: "arrowLeft", isSecondary: false)
}
