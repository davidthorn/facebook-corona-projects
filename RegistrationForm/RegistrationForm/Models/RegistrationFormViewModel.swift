//
//  RegistrationFormViewModel.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct RegistrationFormViewModel: RegistrationFormViewModelProtocol, Hashable {

    var initialFormData: RegistrationOptionalFormData?

    func isFieldValid(field: RegistrationField, value: String?) -> Bool {
        return field.validate(value: value)
    }

    var formSubmitted: (_ formData: RegistrationFormData) -> Void

    static func == (lhs: RegistrationFormViewModel, rhs: RegistrationFormViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(initialFormData)
    }

}
