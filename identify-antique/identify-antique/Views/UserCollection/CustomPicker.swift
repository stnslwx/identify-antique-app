import SwiftUI

struct CustomPicker: View {
    @Binding var selectedOption: ViewOption
    @Namespace var animation
    var body: some View {
        HStack {
            Text("Collection")
                .fontWeight(.medium)
                .font(.system(size: 15))
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .frame(height: 36).frame(maxWidth: .infinity).frame(minWidth: 120)
                .background {
                    ZStack {
                        if selectedOption == .collection {
                            Color.white
                                .cornerRadius(11)
                                .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                }
                .frame(height: 36).frame(maxWidth: .infinity)
                .foregroundColor(selectedOption == .collection ?  .black : .gray)
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.6)) {
                            selectedOption = .collection}
                }
            Text("History")
                .fontWeight(.medium)
                .font(.system(size: 15))
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .frame(height: 36).frame(maxWidth: .infinity)
                .background {
                    ZStack {
                        if selectedOption == .history {
                            Color.white
                                .cornerRadius(11)
                                .frame(height: 36).frame(maxWidth: .infinity)
                                .matchedGeometryEffect(id: "Tab", in: animation)
                        }
                    }
                }
                .foregroundColor(selectedOption == .history ? .black : .gray)
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.6)) {
                            selectedOption = .history}
                }
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .background(Color("customPickerBg"))
        .cornerRadius(16)
    }
}
