import SwiftUI

struct MainTopButton: View {
    let name: String
    var body: some View {
        VStack {
            Image(name)
        }
        .frame(width: 40, height: 40)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

#Preview {
    MainTopButton(name: "base")
}
