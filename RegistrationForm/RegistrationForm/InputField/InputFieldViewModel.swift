//
//  InputFieldViewModel.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct InputFieldViewModel<T: Hashable & CommonTextFieldViewModelProtocol>: InputFieldViewModelProtocol,  Hashable {

    typealias TextFieldViewModel = T

    var identifier: String
    var labelText: NSAttributedString
    var textFieldViewModel: TextFieldViewModel

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(labelText)
    }

    static func ==(lhs: InputFieldViewModel , rhs: InputFieldViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
