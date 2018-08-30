//
//  AnyDatabaseService+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 30/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

extension AnyDatabaseService {

    func itemsObservable(
        isCompleted: Bool = false,
        predicate: NSPredicate? = nil,
        sorted: SortOption? = nil
    ) -> Observable<[ItemType]> {
        return Observable.create { [weak self] observer in
            do {
                try self?.fetch(predicate: predicate, sorted: sorted) { cards in
                    observer.onNext(cards)

                    if isCompleted {
                        observer.onCompleted()
                    }
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
