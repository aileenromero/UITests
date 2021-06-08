  

# ThinkBIT iOS App Boilerplate.

  

  

ThinkBIT iOS Project.

  

  

## Getting Started.

  

This project is a starting point for a iOS application.

  
  

You must first agree to ThinkBIT’s [Employee Manual](https://drive.google.com/a/thinkbitsolutions.com/open?id=18IR-eIXn3I_VMf0S1Pfhf0U0625luW2vWcsoJGuiGB4) and understand ThinkBIT’s [Project Life Cycle](https://drive.google.com/a/thinkbitsolutions.com/open?id=1w26EC2PkIH4HXwlueuotGaqm8z0Pppkmp9HVr0pPjGg) before you proceed.

  
### Using the Boilerplate.

1. Setup project’s bundle identifier and provisioning profiles in [Apple Developer Portal](https://developer.apple.com).
2. Clone the project boilerplate repository [here](https://gitlab.com/thinkbit/ios-app-boilerplate/).
3. Update Display Name and Bundle Identifier
4. Build Project
5. Setup provisioning profile per configuration (Debug, Beta, Production) Debug = Automatic Signing, Beta = AdHoc Provisioning Profile (contains the device id of testers for TestFlight/Firebase App Distribution), Production = Distribution Provisioning Profile.
6. Download the provisioning profiles and save them in Provisioning Profiles folder.
7. Name the provisioning profiles with "Beta" and "Production" accordingly.



### Suggested Pod Dependencies.

  

- [Alamofire](https://github.com/Alamofire/Alamofire) - An HTTP networking library written in Swift.

- [Kingfisher](https://github.com/onevcat/Kingfisher) - a powerful, pure-Swift library for downloading and caching images from the web

- [SwiftDate](https://github.com/malcommac/SwiftDate) - The best way to manage date and time in Swift.

- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions, loosely based on GitHub's Swift Style Guide.

- [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - Allows you to prevent the issue of keyboard sliding up and covering UITextField/UITextView without needing to write any code or make any additional setup

- [KeychainSwift](https://github.com/evgenyneu/keychain-swift) - A collection of helper functions for saving text and data in the Keychain

- [Wormholy](https://github.com/pmusolino/Wormholy) - used to debug network requests and responses

- [Realm Browser](https://itunes.apple.com/ph/app/realm-browser/id1007457278?mt=12) - This is the database browser of Realm if the app uses it as the offline database.

- [Lottie](https://github.com/airbnb/lottie-ios) - natively renders vector based animations and art in realtime with minimal code

- [R.swift](https://github.com/mac-cain13/R.swift) - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects

- More awesome libraries [here](https://swiftpackageindex.com) and [here](https://cocoapods.org).
