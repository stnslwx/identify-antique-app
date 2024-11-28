import SwiftUI

struct ContentView: View {
    
    @AppStorage("isOnboardingShowing") var isOnboardingShowing: Bool = true
    
    @StateObject private var collectionVm = UserCollectionViewModel()
    @StateObject private var collectionSheetModel = CollectionSheetModel()

    @State private var isSideMenuPresented: Bool = false
    @State private var openScanner: Bool = false
    
    @State private var selectedTab: Tab = .main
        
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    TabView(selection: $selectedTab){
                        if selectedTab == .main {
                            MainView(sheetModel: collectionSheetModel, isMenuPresented: $isSideMenuPresented, openScanner: $openScanner)
                        } else {
                            UserCollectionView(
                                collectionVm: collectionVm, collectionSheetModel: collectionSheetModel)
                        }
                    }
                    Spacer()
                }
                VStack {
                    TabNavigationBar(selectedTab: $selectedTab, openScanner: $openScanner, geometry: geometry)
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
            .fullScreenCover(isPresented: $isOnboardingShowing) {
                OnboardingView(isOnboardingShowing: $isOnboardingShowing)
                    .presentationDetents([.fraction(1)])
            }
            .fullScreenCover(isPresented: $collectionSheetModel.isArticleViewPresented) {
                collectionSheetModel.isArticleViewPresented = false
            } content: {
                FullArticleView(sheetModel: collectionSheetModel)
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
