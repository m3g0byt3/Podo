Podo
=======

Non-official iOS application for top-up russian contactless metropolitan multi-tickets "Podorozhnik" and "Sputnik", written in Swift. MVVM-C architecture inspired by [ApplicationCoordinator example](https://github.com/AndreyPanov/ApplicationCoordinator) from [Andrey Panov](https://medium.com/@panovdev). 

Using [Moya](https://github.com/Moya/Moya) for network layer, [Swinject](https://github.com/Swinject/Swinject) assemblies for dependency injection, 
 [RealmSwift](https://github.com/realm/realm-cocoa) for persistence layer and [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift) for MVVM bindings.

![](Screenshots/iPhone1.png)


Project Status
----------------
Not released yet, actively under development.

Features
----------------
Top-up following types of metropolitan transport cards:

- [x] "Podorozhnik" multi-tickets with 19-digit number length
- [x] "Podorozhnik" multi-tickets with 26-digit number length
- [ ] "Sputnik" multi-tickets with 11-digit number length

Using following payment methods for top-up:

- [x] Credit or debit cards
- [ ] Cellphone balance
- [ ] Yandex Money
- [ ] Qiwi Wallet
- [ ] Apple Pay

TODO
----------------

- Payment history persistence (Realm)
- Add more payment methods
- Scan and recognize payment card (CardIO)
- Scan and recognize transport card (Tesseract)
- Show onboarding on first launch
- "Settings" menu
- "Contacts" menu
- "About" menu

Requirements
----------------
* iOS 9.3+
* Xcode 9.0+
* Swift 4.0+

Installation
----------------

```
git clone https://github.com/m3g0byt3/Podo.git\
 && cd Podo\
  && pod install\
   && open Podo.xcworkspace
```

Replace non-valid randomly-generated Firebase configuration files (`./Podo/Supporting\ Files/GoogleService-Info-dev.plist` and `./Podo/Supporting\ Files/GoogleService-Info-prod.plist`) with your own valid configuration files.

Replace non-valid randomly-generated Crashlytics API key and Build secret with working ones in the `api-keys` file.


Contributing
----------------
1. Fork
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

That's it!

Used 3rd party libraries and frameworks
----------------
* [Moya](https://github.com/Moya/Moya)
* [RealmSwift](https://github.com/realm/realm-cocoa)
* [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift)
* [Swinject](https://github.com/Swinject/Swinject)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [EmptyDataSet-Swift](https://github.com/Xiaoye220/EmptyDataSet-Swift)
* [R.swift](https://github.com/mac-cain13/R.swift)
* [Fabric Crashlytics & Answers](https://www.fabric.io/kits)
* [Google Firebase](https://firebase.google.com)
* [PKHUD](https://github.com/pkluz/PKHUD)
* [Quick](https://github.com/Quick/Quick)
* [Nimble](https://github.com/Quick/Nimble)



Author
----------------
[m3g0byt3](https://github.com/m3g0byt3)

License
----------------
Podo is released under an [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license. See [LICENSE.md](LICENSE.md) for more information.