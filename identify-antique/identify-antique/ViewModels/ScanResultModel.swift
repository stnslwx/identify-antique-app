import Foundation
import Alamofire

final class ScanResultModel: ObservableObject {
    
    enum requestStatus {
        case idle, loading, success, failure
    }
    
    @Published var requestStatus: requestStatus = .loading
    @Published var scanData: ScanData?
    @Published var errorMessage: String?
    
    
    func scanRequest(image: UIImage, language: String) {
        let url = URL(string: URLs.gpt)
        
        AF.upload(multipartFormData: { multipartFormData in
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
            multipartFormData.append(language.data(using: .utf8) ?? Data(), withName: "language")
            
        }, to: url!, method: .post)
        .response { response in
            
            if let data = response.data {
                print("Raw Response: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")

                   do {
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .convertFromSnakeCase
                       let decodedData = try decoder.decode(ScanData.self, from: data)
                       DispatchQueue.main.async {
                           self.scanData = decodedData
                           self.requestStatus = .success
                           print("success")
                       }
                   } catch {
                       print("Ошибка декодирования: \(error)")
                       DispatchQueue.main.async {
                           self.requestStatus = .failure
                           self.errorMessage = error.localizedDescription
                       }
                   }
               } else if let error = response.error {
                   print("Ошибка запроса: \(error)")
                   DispatchQueue.main.async {
                       self.requestStatus = .failure
                       self.errorMessage = error.localizedDescription
                   }
               }
            
        }
    }
    
}
