//
//  AddNewCardView.swift
//  Podo
//
//  Created by m3g0byt3 on 26/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol AddNewCardView: View {

    var onSaveButtonTap: Completion? { get set }
    var onScanButtonTap: Completion? { get set }
}
