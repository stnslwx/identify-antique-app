import Foundation

// onboarding
struct OnboardingStrings {
    let pageTitles = ["Identify antique", "More than 1M+ objects", "Show your love", "Get Full Access"]
    let pageDescriptions = [
        "Just point the camera at the subject",
        "Find everything you've been looking for here",
        "Give us a rating in the AppStore",
        "SUBSCRIPTION HERE"
    ]
}
// --------------------------

// main view
struct MainScreenPopular {
    let popularItems: [PopularItem] = [
        PopularItem(name: "Vases",   image: "popular1"),
        PopularItem(name: "Teapots", image: "popular2"),
        PopularItem(name: "Mirrors", image: "popular3"),
        PopularItem(name: "Plates",  image: "popular4"),
        PopularItem(name: "Clock",   image: "popular5"),
        PopularItem(name: "Mirrors", image: "popular6")
    ]
}

struct MainScreenArticles {
    let articles: [Article] = [
        Article(title: "How much is your antique worth? How to find..",
                text: "Whether you are a collector of antiques or have some items from the past..",
                image: "article"),
        Article(title: "How much is your antique worth? How to find..",
                text: "Whether you are a collector of antiques or have some items from the past..",
                image: "article"),
        Article(title: "How much is your antique worth? How to find..",
                text: "Whether you are a collector of antiques or have some items from the past..",
                image: "article")
    ]
}
// --------------------------

// collection item info

struct ItemInfo: Identifiable {
    var id = UUID()
    let title: String
    let text: String
}

struct CollectionItemInfo {
    let itemFacts: [ItemInfo] = [
        ItemInfo(title: "Did you know?", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "),
        ItemInfo(title: "Interesting facts", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ")
    ]
}


struct ArticleText {
    static let title: String = "How much is your antique worth? How to find out"
    static let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit,\n sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}
