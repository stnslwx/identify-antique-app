

import SwiftUI

struct ContentView: View {
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
                                .frame(width: geometry.size.width,height: geometry.size.height)
                                .background(.green)
                        } else {
                            CollectionView()
                                .frame(width: geometry.size.width,height: geometry.size.height)
                                .background(.red)
                        }
                    }
                    Spacer()
                }
                VStack {
                    TabNavigationBar(selectedTab: $selectedTab, geometry: geometry)
                }
            }.frame(maxHeight: .infinity)
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("Main")
    }
}

struct CollectionView: View {
    var body: some View {
        Text("Collection")
    }
}

#Preview {
    ContentView()
}
