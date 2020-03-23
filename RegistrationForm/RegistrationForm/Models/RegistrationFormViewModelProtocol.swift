//
//  RegistrationFormViewModelProtocol.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

protocol RegistrationFormViewModelProtocol {
    var formSubmitted: (_ formData: RegistrationFormData) -> Void { get }
    var initialFormData: RegistrationOptionalFormData? { get }
    func isFieldValid(field: RegistrationField, value: String?) -> Bool
}
