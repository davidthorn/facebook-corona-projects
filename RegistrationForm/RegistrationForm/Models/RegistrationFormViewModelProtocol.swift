//
//  RegistrationFormViewModelProtocol.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

protocol RegistrationFormViewModelProtocol {
    associatedtype TextFieldViewModel: Hashable & CommonTextFieldViewModelProtocol
    associatedtype FieldViewModel: Hashable & InputFieldViewModelProtocol
    var formSubmitted: (_ formData: RegistrationFormData) -> Void { get }
    var initialFormData: RegistrationOptionalFormData? { get }
    func isFieldValid(field: RegistrationField, value: String?) -> Bool
    var textViewChangeHandler: (_ text: String?, _ viewModel: CommonTextFieldViewModelProtocol) -> Void { get }
    var formViewModels: [FieldViewModel] { get }
    var updateViewModels: (_ viewModels: [FieldViewModel]) -> Void { get set }
}
