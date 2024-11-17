import SwiftUI

struct UserCollectionStatistics: View {
    let antiqueCount: Int
    let coutriesCount: Int
    let collectionsCount: Int
    var body: some View {
        HStack(spacing: 9) {
            VStack {
                Text(String(antiqueCount)).font(.system(size: 21, weight: .bold, design: .default))
                Text("Antique").font(.system(size: 11))
            }
            .frame(width: 100, height: 55)
            .background(.white)
            .cornerRadius(20)
            VStack {
                Text(String(coutriesCount)).font(.system(size: 21, weight: .bold, design: .default))
                Text("Country").font(.system(size: 11))
            }
            .frame(width: 100, height: 55)
            .background(.white)
            .cornerRadius(20)
            VStack {
                Text(String(collectionsCount)).font(.system(size: 21, weight: .bold, design: .default))
                Text("Collections").font(.system(size: 11))
            }
            .frame(width: 100, height: 55)
            .background(.white)
            .cornerRadius(20)
        }
    }
}

#Preview {
    UserCollectionStatistics(antiqueCount: 0, coutriesCount: 0, collectionsCount: 0)
}
