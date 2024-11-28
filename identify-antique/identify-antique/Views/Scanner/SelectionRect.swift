import SwiftUI

struct SelectionRect: View {
    
    @ObservedObject var scanModel: ScannerViewModel
    @State private var squareSize: CGFloat = 250
    @GestureState private var gestureSizeChange: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("scannerFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: squareSize + gestureSizeChange, height: squareSize + gestureSizeChange)
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height / 2
                    )
                Circle()
                    .fill(.white)
                    .frame(width: (squareSize + gestureSizeChange) / 8, height: (squareSize + gestureSizeChange) / 8)
                    .overlay(alignment: .center) {
                        Circle()
                            .frame(width: (squareSize + gestureSizeChange) / 5, height: (squareSize + gestureSizeChange) / 5)
                            .foregroundColor(.clear)
                            .contentShape(Circle())
                            .gesture(
                                DragGesture()
                                     .updating($gestureSizeChange) { value, state, _ in
                                         let newSize = squareSize + value.translation.width
                                         state = max(150 - squareSize, min(newSize, geometry.size.width, geometry.size.height) - squareSize)
                                     }
                                     .onEnded { value in
                                         let newSize = squareSize + value.translation.width
                                         squareSize = max(150, min(newSize, min(geometry.size.width, geometry.size.height)))
                                         scanModel.updateSquareRect(for: geometry.size, squareSize: squareSize, gestureSizeChange: gestureSizeChange)
                                     }
                            )

                    }
                    .position(
                        x: geometry.size.width / 2 + (squareSize + gestureSizeChange) / 2,
                        y: geometry.size.height / 2 + (squareSize + gestureSizeChange) / 2
                    )
//                Text("Rect: \(String(format: "%.5f", calculateRect(for: geometry.size).width)), \(String(format: "%.5f", calculateRect(for: geometry.size).height))")
//                    .foregroundColor(.white)
//                    .font(.system(size: 15, weight: .semibold))
//                    .position(x: geometry.size.width / 2, y: geometry.size.height - 50)
            }
            .onAppear {
                scanModel.updateSquareRect(for: geometry.size, squareSize: squareSize, gestureSizeChange: gestureSizeChange)
                print("GestureSizeChange -> \(gestureSizeChange)")
            }
        }
    }
    
    private func calculateRect(for screenSize: CGSize) -> CGRect {
        let currentSize = squareSize + gestureSizeChange
        let originX = (screenSize.width - currentSize) / 2
        let originY = (screenSize.height - currentSize) / 2
        return CGRect(x: originX, y: originY, width: currentSize, height: currentSize)
    }
    
}


