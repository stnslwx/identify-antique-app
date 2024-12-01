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
        Article(title: "Antique business for beginners. What do you need to know and be able to do?",
                text: """
                The antique business is not only collecting, it is a special kind of investment. It's not like investing in housing, stocks, or bitcoin. For example, you bought an apartment today, rented it out and received income a month later. Cultural values don't work that way. It will take at least 5 years for the item to grow in price, but there is no guarantee to make a profit here either. Many factors should converge: the thing should be liquid, the market value for analogues should increase, and the demand for it should remain high.

                Friends will not tell you how to learn this – competition is competition. When you are a collector in the third generation, it is easier for you, but if you want to become the first in your family, it will take a dozen years to study the subject independently. Therefore, in order to speed up the time of entering the profession, there are distance courses, clubs and closed communities for collectors.

                Basic rules for anyone who is going to do antiques
                1. Choose the right direction.

                What do you like: paintings, coins, jewelry, graphics, porcelain? The principle here is the same – you need to invest in what you love. Even if you don't earn anything, enjoy the process: searching for a product, collecting information about it, reading historical literature, studying related topics. There is a gender difference in niches: weapons, tinware, numismatics are preferred by men; ceramics, porcelain, jewelry are preferred by women. This is a trend, but there are no restrictions in the selection of collectibles.

                2. Determine the capital to invest.

                It is necessary to draw up a business plan for at least 3-12 months. There are two rules to follow here.

                First, money should not be the last or deferred savings for loved ones or for housing.

                Secondly, it is necessary to determine the maximum amount that you can spend without harming your family, and never exceed it. Antiques are gambling, but you can't lose your head. You have set your spending on antiques, for example, at $ 1,000 per quarter and cannot spend a penny more, even if you really want to. You can not spend it for the future, on debt, on account of future salary.

                3. Learn and develop.

                Courses, literature, and club memberships cost money, but investments are justified because knowledge and money go hand in hand in this area.

                4. Buy the popular, not the fashionable.

                Paintings by old masters are more profitable to purchase than the avant-garde direction, Dulevsky porcelain is more valuable than a standard Soviet porcelain set. In the pursuit of momentary fashion, chances are great to be left with nothing.

                5. Collectibles must be in perfect condition.

                The principle of "the more the better" does not work here. It is better to have 10 expensive items in perfect condition than 110 with defects. According to the quality of the collected collection, a general idea of you as an antique dealer is formed. The more perfect the items in the collection, the higher the authority and more trust.

                A separate layer of knowledge is associated with terms in collecting. Students are introduced to the concepts of attribution, comprehensive examination of cultural values, expert opinion, technical, technological and materials science research, commodity research and molecular genetics.

                In addition, there are a lot of familiar words that have a different meaning in the slang of an antiquarian.

                Biscuit - unglazed porcelain.

                The boss - small round/oval decoration to mask the seam between the shapes.

                Beads - ornament made of hemispheres soldered to the surface.

                Gloss - metal decoration on glass, ceramics, porcelain.

                The frame - main part or frame of the furniture to which the plywood was glued.

                The Codex - text in the format of a rectangular book with pages stitched together along a common edge.

                A paw - type of furniture leg.

                The legend - inscription on the coin.

                The remainder - metal left over after the tinker made the dishes.

                The meaning of words depends on the niche of collecting, but in order to talk to experts in their language, the terms must be learned.
                """,
                image: "article"),
        Article(title: "Where to look for antiques?",
                text: """
                If you remember the old days, then it was believed that real antiques could be freely bought at the flea market. In fact, that's how it was. In modern times, there are a lot of sources and opportunities to buy real antiques, so flea markets should no longer be trusted. The fact is that if certain rules are taken into account, then each antique item must have a certificate and an expert assessment. Otherwise, it will simply be considered a fake. No one provides such documentation at flea markets. Therefore, it is worth choosing slightly different sources to buy antiques. For example, now you can buy antique items on the Internet, on the website ria.com .


                Buying through such sources is not only profitable, because you can negotiate a price, but also convenient, because you can already assess the condition of an object from a photo. Moreover, many sellers provide copies of documents directly on the website.


                There is also an option to find valuable antiques at auction. You need to have a certain flair there. The fact is that a variety of things are sold there, the cost of which is also not considered fixed. It is necessary to specifically determine which things need to be invested in them. And which ones are not. This is determined by analyzing whether it will be possible to sell this item for a higher value in the future than it was originally given for. It should also be borne in mind that the value of antiques is growing every year. The more promising an item is, the more its price will rise.


                The question immediately arises: "how do I find out the value of antiques bought at auction?". To begin with, you need to learn this profession. This can be done with the help of various courses that exist in almost every city. But you can prepare yourself. First, you need to attend auctions for a long time. In the future, there will be a certain understanding of what things are being sold and how much people are willing to pay for them.


                There is another effective option. You can ask for an appraiser's advice. The thing is. That before the start of each auction, an exhibition of those goods that will be put up for sale is held. You can walk around with a consultant on such an exhibition so that he gives his assessment. Then there will be a clear idea of that. What things are worth buying, as well as for what price they can then be sold.
                """,
                image: "article"),
        Article(title: "Collecting the past or why buy antiques?",
                text: """
                Wouldn't it be better to buy something new? It turns out that antiques are not without their advantages, and their purchase may actually be justified.
                Some consumers do not understand why so many people are looking for antiques and generally pay attention to old things
                It's worth starting with the fact that antique items are purchased for aesthetic reasons. In search of beauty, people not only contemplate paintings and sculptures, not only listen to music written centuries ago, but also surround themselves with beautiful things. And often the objects that delight the eye of an aesthete are vintage furniture or art objects made by famous or nameless craftsmen many years ago.
                Collecting is another reason why antique shops always find their audience. Of course, it's not worth turning collecting and owning things into a passion, but many make it an interesting, non-binding hobby.
                The idea of investing in antiques does not make sense. Of course, doing this without the appropriate knowledge and experience is a risky scam. It is difficult to say how the acquired antiques will be preserved in the next few decades, whether they will increase in price or depreciate. Nevertheless, many antique items are bought for the purpose of further resale. Especially a lot of people buy antiques at auctions.
                Exclusive antique items, including furniture, even after decades of creation remain of higher quality than consumer goods. Therefore, antiques do not always gather dust on the shelves – they continue to be used if it is actually a good, good-quality thing.
                Of course, you need to buy antiques based on experience and knowledge. In order to avoid counterfeiting and not overpay, it is important not only to consult with independent experts and appraisers, but also to cooperate with suppliers who have feedback and recommendations.
                """,
                image: "article"),
        Article(title: "The most famous antiques auctions in the world?",
                text: """
                The bulk of expensive and rare lots are sold at several auctions, whose name has become a household word over the centuries. An antique item or other collectible object purchased at such auctions is a priori quoted as highly as possible and commands respect even from people far from the world of art, not to mention true connoisseurs.

                Stockholm Auction House

                The Stockholm Auction House, founded in 1674, is considered the oldest in the world. Even crowned heads (for example, Charles XI or Gustav III), prominent public and political figures became his clients. Until the end of the 20th century, it belonged to the state, but now it is under private management. It is noteworthy that Stockholm Auction House annually holds Russian auctions, where the creations of our famous compatriots are exhibited.

                The palm of the most famous public auctions is divided equally by 2 "mastodons" – Christie's and Sotheby's. For an artist, author or sculptor to sell works here is a special honor and an automatic increase in the value of the work.

                Christie's Auction House

                Christie's was founded in the capital of Great Britain in 1766 by retired naval officer J. Christie is the eldest. The English nobility and members of the royal family fruitfully interacted with him. Just Christie became an intermediary in the deal for Catherine the Great to acquire the collection of paintings by Sir R. Walpole, which "laid the foundation" for the creation of the Hermitage.

                Sotheby's Auction House

                Sotheby's is an equally glorious auction house, where paintings, watches, diamonds and cars are sold for astronomical sums. The "ancestor" is considered to be Samuel Baker, a bookseller who organized the first auction under his own name in 1744. Then John Sotheby took the initiative, and the auction house still bears his name. And, if initially he worked exclusively with books (he sold, for example, the library of Napoleon from Elba or the collection of Prince Sh. Talleyrand), then a century later antiques, numismatics, and subsequently paintings, furniture, and sculptures were added to them. Progressivity is a distinctive feature of Sotheby's, which began trading online on the Internet in 2000.

                Bonhams Auction House

                Bonhams was opened in Albion in 1793. Rare cars are the main specialty, although sales under the hammer are carried out in 60 categories. Bonhams was the first to open auctions on the subject of street art, introducing the world to Banksy's work.

                """,
                image: "article")
    ]
}
// --------------------------

