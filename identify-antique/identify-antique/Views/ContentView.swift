

import SwiftUI

struct ContentView: View {
    @StateObject private var collectionVm = UserCollectionViewModel()

    @State private var isCreateCollectionSheetPresented: Bool = false
    
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
                            MainView()
                        } else {
                            UserCollectionView(collectionVm: collectionVm, isCreateCollectionPresented: $isCreateCollectionSheetPresented)
                        }
                    }
                    Spacer()
                }
                VStack {
                    TabNavigationBar(selectedTab: $selectedTab, geometry: geometry)
                }
            }
            .frame(maxHeight: .infinity)
            .sheet(isPresented: $isCreateCollectionSheetPresented) {
                isCreateCollectionSheetPresented = false
            } content: {
                CreateCollectionSheet(collectionVm: collectionVm)
                    .presentationDetents([.fraction(0.7)])
            }
        }
    }
}

#Preview {
    ContentView()
}
