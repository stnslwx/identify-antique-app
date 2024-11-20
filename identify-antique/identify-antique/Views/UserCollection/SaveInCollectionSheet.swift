import SwiftUI

struct SaveInCollectionSheet: View {
    @ObservedObject var collectionsVm: UserCollectionViewModel

    @Binding var isCreateCollectionPresented: Bool
    @State private var isInsideCollectionPresented = false
    
    let isSaving = true
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center,spacing: 20) {
                
                VStack{}.frame(width: 35, height: 3).background(Color("collectionSegmentBg")).cornerRadius(20)
                
                Text("Save in").font(.system(size: 18, weight: .bold))
                
                CollectionsListView(collectionsVm: collectionsVm,
                                    isCreateCollectionPresented: $isInsideCollectionPresented,
                                    isInsideCollectionPresented: $isInsideCollectionPresented,
                                    isSaving: isSaving)
                
                Spacer()
                
            }
            .padding(.horizontal, 20).padding(.top, 15)
            .frame(width: geometry.size.width)
        }
    }
}
