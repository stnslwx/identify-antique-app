import SwiftUI

struct LoadingAnimation: View {
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    @State var rotationDegree: Angle = .degrees(0)
    let rotationTracker: Double = 2
    let animationDuration: Double = 0.75
    
    var body: some View {
        VStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.gray)
                .frame(width: 60, height: 60)
                .overlay(alignment: .center) {
                    Circle()
                        .trim(from: circleStart, to: circleEnd)
                        .stroke(style: StrokeStyle(lineWidth: 8,lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("accentGreen"))
                        .frame(width: 60, height: 60)
                        .rotationEffect(rotationDegree)
                }
        }
        .frame(width: 60, height: 60)
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: (rotationTracker * animationDuration) + animationDuration, repeats: true){ _ in
                self.animate()
            }
        }
    }
    
    func getAngle() -> Angle {
        return .degrees(360 * rotationTracker) + .degrees(120)
    }
    func animate() {
        withAnimation(.spring(response: animationDuration * 2)) {
            rotationDegree = .degrees(-57.5)
            circleEnd = 0.325
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(.easeInOut(duration: rotationTracker * animationDuration)) {
                self.rotationDegree += self.getAngle()
            }
        }
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(.easeInOut(duration: (rotationTracker * animationDuration) / 2.25)) {
                circleEnd = 0.95
            }
        }
        Timer.scheduledTimer(withTimeInterval: rotationTracker * animationDuration, repeats: false) { _ in
            rotationDegree = .degrees(47.5)
            withAnimation(.easeInOut(duration: animationDuration)) {
                circleEnd = 0.95
            }
        }
    }
}


#Preview {
    LoadingAnimation()
}
