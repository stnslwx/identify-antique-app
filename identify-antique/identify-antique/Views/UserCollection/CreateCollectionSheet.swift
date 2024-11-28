import SwiftUI

struct CreateCollectionSheet: View {
    
    @ObservedObject var collectionVm: UserCollectionViewModel
    @ObservedObject var collectioSheetsModel: CollectionSheetModel
    @State private var collectionName: String = ""
    @FocusState private var isFocused: Bool 
    
    let isSaving: Bool
    var body: some View {
        VStack {
            VStack{}.frame(width: 35, height: 3)
                .background(Color("collectionSegmentBg"))
                .cornerRadius(20)
                .padding(.bottom, 25)
                .padding(.top, 8)
            Text("Name the collection").font(.system(size: 18, weight: .bold))
            VStack() {
                TextField("", text: $collectionName)
                    .padding(.horizontal)
                    .padding(.top, 90)
                    .overlay(
                       Rectangle()
                           .frame(height: 1)
                           .foregroundColor(Color("textGray"))
                           .offset(y: 5),
                       alignment: .bottom
                    )
                    .focused($isFocused)
                Spacer()
                CreateCollectionButton(collectionName: $collectionName, action: {
                    collectionVm.addCollection(name: collectionName)
                    if isSaving {
                        collectioSheetsModel.isCreateCollFromItemViewPresented = false
                        print("add collection btn: \(collectionName)")
                    } else {
                        collectioSheetsModel.isCreateCollPresent = false
                        print("add collection btn: \(collectionName)")
                    }
                })
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 8)
        .background(.white)
    }
    
    
    struct CreateCollectionButton: View {
        @Binding var collectionName: String
        let action: ()->Void
        var body: some View {
            Button(action:action){
                VStack {
                    Text("Create").font(.system(size: 16, weight: .medium)).foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity).frame(height: 60)
                .background(Color("accentGreen"))
                .overlay(alignment: .center, content: {
                    if collectionName.isEmpty {
                        Color(#colorLiteral(red: 0.8374214172, green: 0.8374213576, blue: 0.8374213576, alpha: 0.6)).frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                })
                .cornerRadius(34)
            }
            .disabled(collectionName.isEmpty)
            .padding(.bottom, 10)
        }
    }
}
