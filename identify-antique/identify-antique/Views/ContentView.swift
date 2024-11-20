

import SwiftUI

struct ContentView: View {
    @StateObject private var collectionVm = UserCollectionViewModel()

    @State private var isCreateCollectionSheetPresented: Bool = false
    @State private var isInsideCollectionSheetPresented: Bool = false
    @State private var isSavinInCollectionSheetPresented: Bool = false
    @State private var isSideMenuPresented: Bool = false
    
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
                            MainView(isMenuPresented: $isSideMenuPresented)
                        } else {
                            UserCollectionView(
                                collectionVm: collectionVm,
                                isCreateCollectionPresented: $isCreateCollectionSheetPresented,
                                isInsideCollectionPresented: $isInsideCollectionSheetPresented)
                        }
                    }
                    Spacer()
                }
                VStack {
                    TabNavigationBar(selectedTab: $selectedTab, geometry: geometry)
                }
                SideMenu(geometry: geometry)
            }
            .frame(maxHeight: .infinity)
            .sheet(isPresented: $isCreateCollectionSheetPresented) {
                isCreateCollectionSheetPresented = false
            } content: {
                CreateCollectionSheet(collectionVm: collectionVm)
                    .presentationDetents([.fraction(0.7)])
            }
            .sheet(isPresented: $isInsideCollectionSheetPresented){
                isInsideCollectionSheetPresented = false
            } content: {
                InsideCollectionSheet()
                    .presentationDetents([.fraction(0.95)])
            }
            .sheet(isPresented: $isSavinInCollectionSheetPresented){
                isSavinInCollectionSheetPresented = false
            } content: {
                SaveInCollectionSheet(collectionsVm: collectionVm, isCreateCollectionPresented: $isCreateCollectionSheetPresented)
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
