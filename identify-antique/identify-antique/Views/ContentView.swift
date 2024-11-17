

import SwiftUI

struct ContentView: View {
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
                            UserCollectionView(isCreateCollectionPresented: $isCreateCollectionSheetPresented)
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
                CreateCollectionSheet()
                    .presentationDetents([.fraction(0.7)])
            }
        }
    }
}

#Preview {
    ContentView()
}
