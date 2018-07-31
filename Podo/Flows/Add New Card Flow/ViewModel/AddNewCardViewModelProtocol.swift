//
//  AddNewCardViewModelProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 27/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

protocol AddNewCardViewModelProtocol {

    var input: AddNewCardViewModelInputProtocol { get }
    var output: AddNewCardViewModelOutputProtocol { get }
}

protocol AddNewCardViewModelInputProtocol {

    var cardNumber: PublishSubject<String> { get }
    var saveState: PublishSubject<Void> { get }
    var themeChanged: PublishSubject<Int> { get }
}

protocol AddNewCardViewModelOutputProtocol {

    var cardNumberText: Observable<String> { get }
    var isCardValid: Observable<Bool> { get }
    var cardTheme: Observable<TransportCardTheme> { get }
}
