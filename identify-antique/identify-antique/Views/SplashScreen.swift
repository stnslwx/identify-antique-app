import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive: Bool = false    
    var body: some View {
        VStack {
            if isActive  {
                ContentView()
            } else {
                VStack {
                    Spacer()
                    Image("splashIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(12)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .ignoresSafeArea(.all, edges: .all)
                .onAppear {
                    Task {
                       await IAPManager.shared.checkSubscriptionStatus()
                        DispatchQueue.main.async {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
