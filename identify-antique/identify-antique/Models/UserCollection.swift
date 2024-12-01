import UIKit
import Foundation

struct CollectionItem: Codable {
    var name: String
    let imageData: Data  // Изображение хранится как Data
    let gptResult: GPTResult
    let itemResult: [ItemResult]
    let raiting: String
        
    init(name: String, image: UIImage, gptResult: GPTResult, itemResult: [ItemResult], raiting: String) {
        self.name = name
        self.imageData = image.jpegData(compressionQuality: 1.0)! // Обязательное изображение
        self.gptResult = gptResult
        self.itemResult = itemResult
        self.raiting = raiting
    }
    
    func getImage() -> UIImage {
        return UIImage(data: imageData)!
    }
}

struct Collection: Identifiable, Codable {
    var id = UUID()
    var name: String
    var items: [CollectionItem] = []
}
