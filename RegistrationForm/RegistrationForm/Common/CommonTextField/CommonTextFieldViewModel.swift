//
//  CommonTextFieldViewModel.swift
//  RegistrationForm
//
//  Created by Thorn, David on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct CommonTextFieldViewModel: CommonTextFieldViewModelProtocol & Hashable {

    var identifier: String
    var value: String?
    var isSecure: Bool
    var placeholder: NSAttributedString
    var textDidChange: (String?, CommonTextFieldViewModelProtocol) -> Void

    init(identifier: String,
         value: String?,
         isSecure: Bool,
         placeholder: NSAttributedString,
         textDidChange: @escaping (String?, CommonTextFieldViewModelProtocol) -> Void) {

        self.identifier = identifier
        self.value = value
        self.isSecure = isSecure
        self.placeholder = placeholder
        self.textDidChange = textDidChange
    }


    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(value)
        hasher.combine(isSecure)
        hasher.combine(placeholder)
    }

    static func == (lhs: CommonTextFieldViewModel, rhs: CommonTextFieldViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}
