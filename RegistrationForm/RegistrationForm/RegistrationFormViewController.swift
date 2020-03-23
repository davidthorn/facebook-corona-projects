//
//  RegistrationFormViewController.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class RegistrationFormViewController<T: RegistrationFormViewModelProtocol & Hashable>: UIViewController {

    typealias ViewModel = T

    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("This should not be called")
    }

    private var optionalFormData = RegistrationOptionalFormData()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let buttonHandler: () -> Void = {
            debugPrint("The button was tapped")
        }

        let textDidChangeHandler: (_ text: String?, _ viewModel: InputFieldViewModelProtocol) -> Void = { [weak self] (updateValue, viewModel) in
            guard let strongSelf = self else { return }

            let fieldValue = RegistrationField(rawValue: viewModel.identifier)


            switch fieldValue {
            case .name:
                strongSelf.optionalFormData.name = nil
                guard strongSelf.viewModel.isFieldValid(field: fieldValue, value: updateValue) else {
                    return
                }
                strongSelf.optionalFormData.name = updateValue
            case .lastname:
                strongSelf.optionalFormData.lastname = nil
                guard strongSelf.viewModel.isFieldValid(field: fieldValue, value: updateValue) else { return }
                strongSelf.optionalFormData.lastname = updateValue
            case .email:
                strongSelf.optionalFormData.email = nil
                guard strongSelf.viewModel.isFieldValid(field: fieldValue, value: updateValue) else { return }
                strongSelf.optionalFormData.email = updateValue
            case .password:
                strongSelf.optionalFormData.password = nil
                guard strongSelf.viewModel.isFieldValid(field: fieldValue, value: updateValue) else { return }
                strongSelf.optionalFormData.password = updateValue
            case .passwordConf:
                strongSelf.optionalFormData.passwordConf = nil
                 guard strongSelf.viewModel.isFieldValid(field: fieldValue, value: updateValue) else { return }
                strongSelf.optionalFormData.passwordConf = updateValue
            }

            guard let formData = strongSelf.optionalFormData.formData else { return  }
            strongSelf.viewModel.formSubmitted(formData)
        }

        let viewModels = RegistrationField.allCases.map { field in
            return InputFieldViewModel(identifier: field.rawValue,
                                       labelText: NSAttributedString(string: field.label),
                                       placeholder: NSAttributedString(string: field.placeholder),
                                       value: nil, textDidChange: textDidChangeHandler)
        }

        let buttonViewModel = FormButtonViewModel(identifier: UUID().uuidString,
                                                  labelText:  NSAttributedString(string: "Submit"),
                                                  tapHandler: buttonHandler)

        let wrapper = UIView()
        let button = FormButton<FormButtonViewModel>()
        wrapper.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -15),
            button.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 15),
            button.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -15)
        ])

        viewModels.forEach { viewModel in
            let inputField = InputField<InputFieldViewModel>()
            inputField.setup(viewModel: viewModel)
            stackView.addArrangedSubview(inputField)
        }

        stackView.addArrangedSubview(wrapper)
        button.setup(viewModel: buttonViewModel)
    }

}
