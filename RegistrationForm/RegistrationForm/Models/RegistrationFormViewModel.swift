//
//  RegistrationFormViewModel.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

final class RegistrationFormViewModel: RegistrationFormViewModelProtocol, Hashable {

    typealias TextFieldViewModel = CommonTextFieldViewModel
    typealias FieldViewModel = InputFieldViewModel<TextFieldViewModel>
    private var optionalFormData: RegistrationOptionalFormData? = RegistrationOptionalFormData()
    var textViewChangeHandler: (String?, CommonTextFieldViewModelProtocol) -> Void = { _,_ in }
    var updateViewModels: (_ viewModels: [FieldViewModel]) -> Void = { _ in }
    var initialFormData: RegistrationOptionalFormData?
    var formSubmitted: (_ formData: RegistrationFormData) -> Void

    var formViewModels: [FieldViewModel] = []

    init(initialFormData: RegistrationOptionalFormData?,
         formSubmitted: @escaping (_ formData: RegistrationFormData) -> Void) {

        self.initialFormData = initialFormData
        self.formSubmitted = formSubmitted

        textViewChangeHandler = _textDidChangeHandler
        formViewModels = RegistrationField.allCases.map { field -> FieldViewModel in
            let textFieldViewModel = TextFieldViewModel(identifier: field.rawValue,
                                                        value: nil,
                                                        isSecure: field.isSecure,
                                                        placeholder: NSAttributedString(string: field.placeholder),
                                                        textDidChange: textViewChangeHandler)

            return FieldViewModel(identifier: field.rawValue,
                                  labelText: NSAttributedString(string: field.label),
                                  textFieldViewModel: textFieldViewModel)
        }


    }

    func isFieldValid(field: RegistrationField, value: String?) -> Bool {
        switch field {
        case .passwordConf:
            return optionalFormData?.password == value &&
                isFieldValid(field: .password, value: optionalFormData?.password)
        default:
            return field.validate(value: value)
        }
    }

    static func == (lhs: RegistrationFormViewModel, rhs: RegistrationFormViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(initialFormData)
    }

    lazy var _textDidChangeHandler: (_ text: String?, _ viewModel: CommonTextFieldViewModelProtocol) -> Void = { [weak self](updateValue, viewModel) in

        guard let strongSelf = self else { return }
        let fieldValue = RegistrationField(rawValue: viewModel.identifier)

        switch fieldValue {
        case .name:
            strongSelf.optionalFormData?.name = nil
            guard strongSelf.isFieldValid(field: fieldValue, value: updateValue) else {
                return strongSelf.handleError(field: fieldValue, viewModel: viewModel)
            }
            strongSelf.optionalFormData?.name = updateValue
        case .lastname:
            strongSelf.optionalFormData?.lastname = nil
            guard strongSelf.isFieldValid(field: fieldValue, value: updateValue) else { return }
            strongSelf.optionalFormData?.lastname = updateValue
        case .email:
            strongSelf.optionalFormData?.email = nil
            guard strongSelf.isFieldValid(field: fieldValue, value: updateValue) else { return }
            strongSelf.optionalFormData?.email = updateValue
        case .password:
            strongSelf.optionalFormData?.password = nil
            guard strongSelf.isFieldValid(field: fieldValue, value: updateValue) else { return }
            strongSelf.optionalFormData?.password = updateValue
        case .passwordConf:
            strongSelf.optionalFormData?.passwordConf = nil
            guard strongSelf.isFieldValid(field: fieldValue, value: updateValue) else { return }
            strongSelf.optionalFormData?.passwordConf = updateValue
        }

        guard let formData = strongSelf.optionalFormData?.formData else { return  }
        strongSelf.formSubmitted(formData)
    }

    private func handleError(field: RegistrationField, viewModel: CommonTextFieldViewModelProtocol) {
        var viewModelToUpdate = [FieldViewModel]()

        switch field {
        case .name:
            guard let fieldViewModel = formViewModels.first(where: { $0.identifier == viewModel.identifier }) else {
                return
            }

            viewModelToUpdate.append(FieldViewModel(identifier: fieldViewModel.identifier,
                                                   labelText: NSAttributedString(string: "Error"),
                                                   textFieldViewModel: fieldViewModel.textFieldViewModel))
        case .lastname:
            break
        case .email:
            break
        case .password:
           break
        case .passwordConf:
            break
        }

        updateViewModels(viewModelToUpdate)
    }
}
