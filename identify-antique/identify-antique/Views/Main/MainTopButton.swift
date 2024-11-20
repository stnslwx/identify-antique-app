import SwiftUI

struct MainTopButton: View {
    let name: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            VStack {
                Image(name)
            }
            .frame(width: 40, height: 40)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        })
    }
}
