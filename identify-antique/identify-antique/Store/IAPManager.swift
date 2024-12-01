import StoreKit
import Foundation

class IAPManager: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate, ObservableObject {
    static let shared = IAPManager()
    
    @Published var isPurchased: Bool = false
    @Published var hasValidSubscription: Bool = false
    
    private var products: [SKProduct] = []
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func requestProducts() {
        let productIdentifiers = Set(["com.identifyantique.yearly"])
        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        debugPrint("IAPManager(productsRequest) - products: \(products)")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                self.isPurchased = true
                debugPrint("Purchased \(isPurchased)")
            case .failed:
                debugPrint("Purchase Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                self.isPurchased = true
                debugPrint("Restored")
            default:
                debugPrint("Default")
                break
            }
        }
    }
    
    func purchaseProduct() {
        guard let product = products.first else { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func checkSubscriptionStatus() async {
        do {
            for await verificationResult in Transaction.currentEntitlements {
                if case .verified(let transaction) = verificationResult {
                    if transaction.productType == .autoRenewable {
                        if let expirationDate = transaction.expirationDate, expirationDate > Date() {
                            DispatchQueue.main.async {
                                self.isPurchased = true
                                print("IAPManager(checkSubscriptionStatus) - VALID >>>")
                                print(verificationResult)
                            }
                        }
                    }
                } else {
                    debugPrint("IAPManager(checkSubscriptionStatus) - NOT VERIFIED >>>")
                }
            }
        }
    }
    
}
