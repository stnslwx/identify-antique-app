import SwiftUI

struct PaywallView: View {
    
    @ObservedObject private var iapManager = IAPManager.shared
    @Binding var showPaywall: Bool
    @State private var showCloseBtn: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
                VStack{
                    Image("ob4")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height * 0.75)
                        .frame(maxHeight: geometry.size.height * 0.8)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .topTrailing) {
                    if showCloseBtn {
                        Image("xmarkGray").resizable().frame(width: 14, height: 14).padding(.top,20).padding(.trailing,20)
                            .onTapGesture {
                                showPaywall = false
                            }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    Text("Get Full Access")
                        .font(.system(.title, design: .default, weight: .bold))
                        .padding(.bottom, 26)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Yearly")
                                .font(.system(size: 17, weight: .bold, design: .default))
                            Spacer()
                            Text("3-Day Free Trial ")
                                        .font(.system(size: 13, weight: .medium))
                                    + Text("(then $39.99/year)")
                                        .font(.system(size: 13, weight: .thin))
                        }
                        Spacer()
                        Image("onboardingSelectedIcon")
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.85, height: 70)
                    .background(Color("transparentGreen"))
                    .cornerRadius(20)
                    .padding(.bottom, 17)
                    
                    Button {
                        print("Paywall Continue btn >>>")
                        Task {
                            await waitForPurchase()
                            showPaywall = false
                        }
                        IAPManager.shared.requestProducts()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            IAPManager.shared.purchaseProduct()
                       }
                    } label: {
                        HStack{
                            Text("Continue")
                                .foregroundStyle(.white)
                                .font(.system(size: 17, weight: .medium, design: .default))
                        }
                        .frame(width: geometry.size.width * 0.85,height: 63)
                        .background(Color("accentGreen"))
                        .cornerRadius(34)
                    }.buttonStyle(PlainButtonStyle())
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                .background(.white)
                .cornerRadius(37)
                .padding(.bottom, 30)
                
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            IAPManager.shared.requestProducts()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                   showCloseBtn = true
                }
           }
        }
    }
    
    private func waitForPurchase() async {
        while !iapManager.isPurchased {
            try? await Task.sleep(nanoseconds: 200_000_000)
        }
    }
    
}
