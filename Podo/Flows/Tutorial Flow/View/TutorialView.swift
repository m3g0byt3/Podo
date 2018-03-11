//
//  TutorialView.swift
//  Podo
//
//  Created by m3g0byt3 on 09/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol TutorialView: View {

    var onNext: Completion? { get set }
    var onSkip: Completion? { get set }
}
