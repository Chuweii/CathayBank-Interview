CathayBankInterview
A modular iOS sample project demonstrating a clean, testable architecture for fetching and presenting remote data. It showcases repository-driven networking, lightweight decoding helpers, and a simple custom tab structure driving a Home flow with account balances, favorites, notifications, and ad banners.

Features
• Home screen
   • Total balance for USD and KHR (first-open and pull-to-refresh scenarios)
   • Favorites section (empty vs populated)
   • Ad banner carousel
   • Notification bell that navigates to a detailed notification list
• Notification list screen
   • Displays read/unread status, title, time, and message
• Custom tab container with a Home tab (stubs for other tabs)
• Data layer
   • API routing centralization (APIInfo)
   • Generic decoding helper (DecodingRequesting)
   • Repositories per domain (Accounts, Favorites, Notifications, Banners)

Architecture
The app follows a layered approach:
• Presentation
   • View controllers and custom views (UIKit)
   • HomeViewController, NotificationViewController, BalanceAccountView, MyFavoriteView, AdBannerView, TabBarViewController
• View Model
   • HomeViewModel coordinates data requests and exposes @Published state
• Domain/Repository
   • AccountBalanceRepository, FavoriteRepository, NotificationRepository, BannerRepository
   • Each repository hides networking details and returns domain models via completion handlers
• Networking
   • APIManager wraps URLSession
   • APIInfo centralizes endpoints
   • DecodingRequesting protocol provides a reusable JSON decoding helper

   Requirements
• Xcode 15+
• iOS 17+
• Swift 5.9+
