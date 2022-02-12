# WonderTinder
 Wonder Tinder App

### 1. Futures

  - [x] Target IOS 13
  - [x] No use Xib/Storyboard
  - [x] Support Iphone landscape/portrait
  - [x] Use MVVM pattern
  - [x] Use Modular architecture 
  - [x] Write Unit Test

### 1. Local Modular Library
   - [x] WonderModel: Package with API Model and Realm singleton.
  
        - Codable Model.
        - Pesisted Model.
        - Real read/save/delete database object.

   - [x] WonderNetwork: Package with Endpoint and Network singleton.
  
        - Endpoint.
        - Get characters.

   - [x] WonderResources: Package with app resources.
  
        - Resources Colors/Font/Local Image.
        - Manager Colors/Font/Local Image.

   - [x] WonderUI: Package with app UI.
  
        - Base ViewController/View/Viewmodel protocol.
        - Home view.
        - Summary view.
        
   - [x] WonderNavigator: Package with app Navigator.
  
        - Base Navigator protocol.
        - App Navigator.
        
# Other

### External Library
  - [x] Alamofire: Alamofire is an HTTP networking library written in Swift.
  
        - Swift Concurrency Support Back to iOS 13, macOS 10.15, tvOS 13, and watchOS 6.
        - URL / JSON Parameter Encoding.
        - HTTP Response Validation.
        - Download File using Request or Resume Data
  
  - [x] Kingfisher: for downloading and caching images.
  
        - Asynchronous image downloading and caching.
        - Loading image from either URLSession-based networking.
        - Cancelable downloading and auto-reusing previous downloaded content to improve performance.
        - Customizable placeholder while loading images.
        
  - [x] Pinlayout: "No Auto layout constraints attached".
  
        - Manual layouting (doesn't rely on auto layout).
        - Full control: You're in the middle of the layout process, no magic black box.
        - Layout one view at a time. Make it simple to code and debug.
        - Concise syntax. Layout most views using a single line.
  
  - [x] Realm: Realm is a mobile database that runs directly inside phones, tablets or wearables.
  
        - Realm’s object-oriented data model is simple to learn, doesn’t need an ORM, and lets you write less code.
        - Realm’s local database persists data on-disk, so apps work as well offline as they do online.
        - Realm is fully-featured, lightweight, and efficiently uses memory, disk space, and battery life.
