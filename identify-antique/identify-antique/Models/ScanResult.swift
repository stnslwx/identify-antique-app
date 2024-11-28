import Foundation

struct GPTResult: Codable {
    let title: String
    let label: [String]
    let facts: [String]
    let didYouKnow: String
    let price: String
    let description: String
    let specifications: [String]
    let performance: String
    let interior: String
    let exterior: String
}

struct ItemResult: Codable {
    let title: String
    let source: String
    let link: String
    let imageUrl: String
}

struct ScanData: Codable {
    let gptResult: GPTResult
    let itemResult: [ItemResult]
}

