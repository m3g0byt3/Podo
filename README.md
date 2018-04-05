Podo
=======

Non-official iOS application for top-up russian contactless metropolitan multi-tickets "Podorozhnik" and "Sputnik", written in Swift. MVVM-C architecture inspired by [ApplicationCoordinator example](https://github.com/AndreyPanov/ApplicationCoordinator) from [Andrey Panov](https://medium.com/@panovdev). 

Using [Moya](https://github.com/Moya/Moya) for the network abstraction, [RealmSwift](https://github.com/realm/realm-cocoa) for persistence layer and [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift) for MVVM bindings.

![](Screenshots/iPhone1.png)

(Not an actual application design, just very early Sketch prototype.)

Project Status
----------------
Not released yet, actively under development.

Features
----------------
Top-up following types of metropolitan transport cards:

- "Podorozhnik" multi-tickets with 19-digit number length
- "Podorozhnik" multi-tickets with 26-digit number length
- "Sputnik" multi-tickets with 11-digit number length

Using following payment methods for top-up:

- Credit or debit cards
- Cellphone balance
- Yandex Money
- Qiwi Wallet
- Apple Pay

Requirements
----------------
* iOS 9.3+
* Xcode 9.0+
* Swift 4.0+

Used 3rd party libraries and frameworks
----------------
* [Moya](https://github.com/Moya/Moya)
* [RealmSwift](https://github.com/realm/realm-cocoa)
* [RxSwift & RxCocoa](https://github.com/ReactiveX/RxSwift)
* [Swinject](https://github.com/Swinject/Swinject)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [EmptyDataSet-Swift](https://github.com/Xiaoye220/EmptyDataSet-Swift)
* [R.swift](https://github.com/mac-cain13/R.swift)
* [SwiftLint](https://github.com/realm/SwiftLint)
* [Quick](https://github.com/Quick/Quick)
* [Nimble](https://github.com/Quick/Nimble)


Contributing
----------------
1. Fork
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

That's it!

Author
----------------
[m3g0byt3](https://github.com/m3g0byt3)

License
----------------
Podo is released under an [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license. See [LICENSE.md](LICENSE.md) for more information.