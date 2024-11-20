import SwiftUI

struct SideMenuView<RenderView: View>: View {
    
    @ViewBuilder var content: RenderView
    @Binding var isSideMenuPresented: Bool
    
    var diriection: Edge
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSideMenuPresented {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isSideMenuPresented.toggle()
                    }
                content
                    .transition(.move(edge: diriection))
                    .background(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isSideMenuPresented)
    }
}
