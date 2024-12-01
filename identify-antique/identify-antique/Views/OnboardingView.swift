import SwiftUI
import StoreKit
import KeychainSwift

struct OnboardingView: View {
    @Binding var isOnboardingShowing: Bool
    
    @State private var currentPage = 0
    @State private var showCloseBtn: Bool = false
    
    let totalPages = 4
    let pageTitles = OnboardingStrings().pageTitles
    let pageDescriptions = OnboardingStrings().pageDescriptions
        
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.bottom) {
                TabView(selection: $currentPage) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        OnboardingImageView(geometry: geometry, imageName: "ob\(index + 1)")
                            .tag(index)
                            .overlay(alignment: .topTrailing) {
                                if currentPage == 3 {
                                    if showCloseBtn {
                                        Image("xmarkGray").resizable().frame(width: 14, height: 14).padding(.top,20).padding(.trailing,20)
                                            .onTapGesture {
                                            
                                                isOnboardingShowing = false
                                            }
                                    }
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.top)
                
                OnboardingInterface(geometry: geometry, currentPage: $currentPage, showCloseBtn: $showCloseBtn, totalPages: totalPages, title: pageTitles[currentPage], description: pageDescriptions[currentPage], isOnboardingShowing: $isOnboardingShowing)
            
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            IAPManager.shared.requestProducts()
        }
    }
}

struct OnboardingInterface: View {
    @ObservedObject var iapManager = IAPManager.shared

    let geometry: GeometryProxy
    @Binding var currentPage: Int
    @Binding var showCloseBtn: Bool
    let totalPages: Int
    let title: String
    let description: String
    @Environment(\.requestReview) var requestReview
    @Binding var isOnboardingShowing: Bool
    var body: some View {
        VStack{
            OnboardingPageIndicator(currentPage: $currentPage, totalPages: totalPages)
                .padding(.bottom, 40)
                .padding(.top, 25)
            VStack(spacing: 19) {
                Text(title)
                    .font(.system(.title, design: .default, weight: .bold))
                    .transition(.opacity)
                    .animation(.smooth(duration: 0.1), value: currentPage)
                if currentPage < totalPages - 1  {
                    Text(description)
                        .frame(maxWidth: 216)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 19, weight: .thin, design: .default))
                        .transition(.opacity)
                        .animation(.smooth(duration: 0.1), value: currentPage)
                } else {
                    OnboardingSubscriptionPlan(geometry: geometry)
                        .transition(.move(edge: .leading))
                }
            }
            Spacer()
            ContinueButton(action: {
                if currentPage == 3 {
                    Task {
                        await waitForPurchase()
                        isOnboardingShowing = false
                    }
                    IAPManager.shared.requestProducts()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        IAPManager.shared.purchaseProduct()
                   }
                }
                nextPage()
            }, geometry: geometry)
                .padding(.bottom)
        }
        .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
        .background(.white)
        .cornerRadius(37)
    }
    
    @MainActor func nextPage(){
        if currentPage < totalPages - 1 {
            withAnimation(.easeInOut(duration: 0.2)) {
                currentPage += 1
            }
        }
        
        if currentPage == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                requestReview()
            }
        }
        
        if currentPage == 3 {
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

struct OnboardingImageView: View {
    let geometry: GeometryProxy
    let imageName: String
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height * 0.75)
                .frame(maxHeight: geometry.size.height * 0.8)
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}
// для 1 * 0.78
// для 2 полный сайз
// 3 - 0.75
// 4 0.8

struct OnboardingSubscriptionPlan: View {
    let geometry: GeometryProxy
    var body: some View {
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
    }
}

struct OnboardingPageIndicator: View {
    @Binding var currentPage: Int
    let totalPages: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color("accentGreen") : Color("transparentGreen"))
                    .frame(width: 57, height: 5)
                    .animation(.snappy(duration: 0.2), value: currentPage)
            }
        }
    }
}

struct ContinueButton: View {
    let action: ()->Void
    let geometry: GeometryProxy
    var body: some View {
        Button(action: action) {
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
}
