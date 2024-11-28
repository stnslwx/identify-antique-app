import UIKit
import Foundation

// UCItem - User Collection Item
 struct UCItem {
    let id = UUID()
    let image: UIImage
    let gptResult: GPTResult
    let itemResult: [ItemResult]
    
    init(image: UIImage, scanData: ScanData) {
        self.image = image
        self.gptResult = scanData.gptResult
        self.itemResult = scanData.itemResult
    }
}
