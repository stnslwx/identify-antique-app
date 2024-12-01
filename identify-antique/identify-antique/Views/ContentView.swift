import SwiftUI
import KeychainSwift

struct ContentView: View {
    
    @AppStorage("isOnboardingShowing") var isOnboardingShowing: Bool = true
    @AppStorage("scanCount") var scanCount: Int = 0
    @AppStorage("reviewCount") var reviewCount: Int = 0
    
    @Environment(\.requestReview) var requestReview
    
    @StateObject private var collectionVm = UserCollectionViewModel()
    @StateObject private var collectionSheetModel = CollectionSheetModel()

    @State private var isSideMenuPresented: Bool = false
    @State private var openScanner: Bool = false
    @State private var showPaywall: Bool = false
    @State private var showOb: Bool = false
    
    @State private var selectedTab: Tab = .main
    
    let keychain = KeychainSwift()
        
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    TabView(selection: $selectedTab){
                        if selectedTab == .main {
                            MainView(sheetModel: collectionSheetModel, isMenuPresented: $isSideMenuPresented, openScanner: $openScanner, showPaywall: $showPaywall)
                        } else {
                            UserCollectionView(
                                collectionVm: collectionVm, collectionSheetModel: collectionSheetModel)
                        }
                    }
                    Spacer()
                }
                VStack {
                    TabNavigationBar(selectedTab: $selectedTab, openScanner: $openScanner, showPaywall: $showPaywall, geometry: geometry)
                }
                SideMenu(geometry: geometry)
            }
            .frame(maxHeight: .infinity)
            .sheet(isPresented: $collectionSheetModel.isCreateCollPresent) {
                collectionSheetModel.isCreateCollPresent = false
            } content: {
                CreateCollectionSheet(collectionVm: collectionVm, collectioSheetsModel: collectionSheetModel, isSaving: false)
                    .presentationDetents([.fraction(0.7)])

            }
            .sheet(isPresented: $collectionSheetModel.isInsideCollPresented){
                collectionSheetModel.isInsideCollPresented = false
            } content: {
                InsideCollectionSheet(collectionsVm: collectionVm, collectionSheetModel: collectionSheetModel)
                    .presentationDetents([.fraction(0.95)])
            }
            .fullScreenCover(isPresented: $openScanner) {
                openScanner = false
            } content: {
                ScannerView(collectionVm: collectionVm,collectionSheetModel: collectionSheetModel,openScanner: $openScanner)
            }
            .fullScreenCover(isPresented: $showOb) {
                keychain.set(true, forKey: "hasSeenOnboarding")
            } content: {
                OnboardingView(isOnboardingShowing: $showOb)
                    .presentationDetents([.fraction(1)])
            }
            .fullScreenCover(isPresented: $collectionSheetModel.isArticleViewPresented) {
                collectionSheetModel.isArticleViewPresented = false
            } content: {
                FullArticleView(sheetModel: collectionSheetModel)
            }
            .fullScreenCover(isPresented: $showPaywall) {
                showPaywall = false
            } content: {
                PaywallView(showPaywall: $showPaywall)
            }
            .onAppear {
                let hasSeenOnboarding = keychain.getBool("hasSeenOnboarding") ?? false
                if !hasSeenOnboarding {
                    showOb = true
                }
                print("seen ob \(hasSeenOnboarding)")
                if scanCount == 2 && reviewCount < 1{
                    requestReview()
                    reviewCount += 1
                }
            }
        }
    }
    
    @ViewBuilder
    private func SideMenu (geometry: GeometryProxy) -> some View {
        SideMenuView(content: {
            SideMenuContentView(presentSideMenu: $isSideMenuPresented)
                .frame(width: geometry.size.width * 0.75)
        }, isSideMenuPresented: $isSideMenuPresented, diriection: .trailing)
    }
}

#Preview {
    ContentView()
}
