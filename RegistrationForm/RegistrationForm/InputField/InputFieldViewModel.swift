//
//  InputFieldViewModel.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct InputFieldViewModel: InputFieldViewModelProtocol,  Hashable {

    var identifier: String
    var labelText: NSAttributedString
    var placeholder: NSAttributedString
    var value: String?
    var textDidChange: (_ value: String?, _ viewModel: InputFieldViewModelProtocol) -> Void

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(labelText)
        hasher.combine(placeholder)
        hasher.combine(value)
    }

    static func ==(lhs: InputFieldViewModel , rhs: InputFieldViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
