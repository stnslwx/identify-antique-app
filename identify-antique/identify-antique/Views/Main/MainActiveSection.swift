import SwiftUI

struct MainActiveSection: View {
    var body: some View {
        VStack(spacing: 14) {
            GetFullAccessSection()
            ScanNowSection()
        }
    }
}

struct GetFullAccessSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Get Full Access").font(.system(size: 19, weight: .bold, design: .default))
                Text("Unlock all app functions").font(.system(size: 14, weight: .medium, design: .default))
                SectionButton(action: {print("tryForFree")}, label: "Try for Free", size: (130,39), textColor: .black, background: false)
            }.foregroundColor(.white)
            Spacer()
        }
        .padding(20)
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .background(ImageBg())
        .cornerRadius(23)
    }
    
    struct ImageBg: View {
        var body: some View {
            HStack{
                Spacer()
                Image("getFullAccessBg2")
                    .overlay(alignment: .trailing) {
                        Image("getFullAccessBg")
                    }
            }
            .background(Color("accentGreen"))
            .cornerRadius(23)
        }
    }
}

struct ScanNowSection: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Find an antique").font(.system(size: 19, weight: .bold, design: .default))
                Spacer()
                Text("Take photos and expand your collection").font(.system(size: 15, weight: .regular, design: .default)).lineLimit(nil) .multilineTextAlignment(.leading).frame(width: 160).foregroundColor(Color("textGray"))
                Spacer()
                SectionButton(action: {print("GetFullAcces")}, label: "Scan now", size: (136,46), textColor: .white, background: true)
            }.foregroundColor(.black)
            Spacer()
        }
        .padding(20)
        .frame(height: 165)
        .frame(maxWidth: .infinity)
        .background(ImageBg())
        .cornerRadius(23)
    }
    
    struct ImageBg: View {
        var body: some View {
            HStack{
                Spacer()
                Image("layer1")
                    .overlay(alignment: .trailing) {
                        Image("layer2")
                            .overlay(alignment: .center) {
                                Image("layer3")
                            }
                    }
            }
            .background(.white)
            .cornerRadius(23)
        }
    }
}


struct SectionButton: View {
    let action: ()->Void
    let label: String
    let size: (width: CGFloat, height: CGFloat)
    let textColor: Color
    let background: Bool
    var body: some View {
        Button(action: action) {
            VStack {
                Text(label).font(.system(size: 18, weight: .semibold, design: .default)).foregroundStyle(textColor)
            }
            .frame(width: size.width, height: size.height)
            .background(background ? Color("accentGreen") : .white)
            .cornerRadius(23)
        }
    }
}


#Preview {
    MainActiveSection()
}
