import SwiftUI

struct MainView: View {
    @ObservedObject var sheetModel: CollectionSheetModel
    @Binding var isMenuPresented: Bool
    @Binding var openScanner: Bool
    @Binding var showPaywall: Bool
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            OffsetableScrollView { point in
                withAnimation(.easeInOut(duration: 0.2)){
                    scrollOffset = point.y
                }
            } content: {
                VStack {
                    ZStack(alignment:.bottom) {
                        VStack {
                            MainTopView(isMenuPresented: $isMenuPresented, geometry: geometry)
                            Spacer()
                        }
                        MainScrollView(sheetModel: sheetModel, openScanner: $openScanner, showPaywall: $showPaywall)
                            .offset(y: 180)
                    }.frame(maxHeight: .infinity)
                }
            }
            .overlay(alignment: .top, content: {
                HStack {
                    //MainTopButton(name: "info", action: {print("info")})
                    Spacer()
                    MainTopButton(name: "settings", action: {isMenuPresented = true})
                }
                .padding(.top, 30)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .background {
                    if scrollOffset < -40 {
                        Color("accentGreen")
                            .edgesIgnoringSafeArea(.top)
                    }
                }
            })
            .offset(y: -20)
        }
    }
}


private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct OffsetableScrollView<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: T
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = false,
         offsetChanged: @escaping (CGPoint) -> Void = { _ in},
         @ViewBuilder content: () -> T
    ){
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("ScrollView")).origin)
            }
            .frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "ScrollView")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: offsetChanged)
    }
}
