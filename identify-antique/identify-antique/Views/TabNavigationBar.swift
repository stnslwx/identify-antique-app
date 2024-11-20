import SwiftUI

enum Tab: String, CaseIterable {
    case main
    case collection
}

struct TabNavigationBar: View {    
    @Binding var selectedTab: Tab
    @Binding var openScanner: Bool
    
    let geometry: GeometryProxy
    
    private var fillImage: String {
        selectedTab.rawValue + "Fill"
    }
    
    var body: some View {
        HStack(spacing: 150) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                VStack {
                    Image(selectedTab == tab ? fillImage: tab.rawValue )
                    Text(tab.rawValue.capitalized)
                        .foregroundStyle(selectedTab == tab ? Color("accentGreen"): Color("tabGrey"))
                }
                .frame(width: 80)
                .onTapGesture {
                    selectedTab = tab
                }
            }
        }
        .padding(.horizontal, 50)
        .frame(width: geometry.size.width, height: geometry.size.height * 0.11)
        .background(.white)
        .overlay(alignment: .top) {
            ScanButton(openScanner: $openScanner)
                .offset(y: -30)
        }
    }
}




struct ScanButton: View {
    @Binding var openScanner: Bool
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 80, height: 80)
            .overlay(alignment: .center) {
                Circle()
                    .fill(Color("accentGreen"))
                    .frame(width: 75, height: 75)
                    .overlay(alignment: .center) {
                        Image("scan")
                            .overlay(alignment: .bottom) {
                                Text("Scan")
                                    .frame(width: 80)
                                    .foregroundStyle(Color("tabGrey"))
                                    .offset(y: 40)
                            }
                    }
            }
            .onTapGesture {
                openScanner = true
            }
    }
}
