import Foundation

struct OnboardingStrings {
    let pageTitles = ["Identify antique", "More than 1M+ objects", "Show your love", "Get Full Access"]
    let pageDescriptions = [
        "Just point the camera at the subject",
        "Find everything you've been looking for here",
        "Give us a rating in the AppStore",
        "SUBSCRIPTION HERE"
    ]
}

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
