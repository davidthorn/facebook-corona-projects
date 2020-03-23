//
//  RegistrationFormViewController.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

enum RegistrationField: String, CaseIterable{

    init(rawValue: String) {
        switch rawValue {
        case RegistrationField.name.rawValue:
            self = .name
        case RegistrationField.lastname.rawValue:
            self = .lastname
        case RegistrationField.email.rawValue:
            self = .email
        case RegistrationField.password.rawValue:
            self = .password
        case RegistrationField.passwordConf.rawValue:
            self = .passwordConf
        default:
            fatalError("Invalid field type")
        }
    }

    case name
    case lastname
    case email
    case password
    case passwordConf

    var placeholder: String {
        switch self {
        case .name:
            return "Enter your name"
        case .lastname:
            return "Enter your lastname"
        case .email:
            return "Enter your email"
        case .password:
            return "Enter your password"
        case .passwordConf:
            return "Confirm your password"
        }
    }

    var label: String {
        switch self {
        case .name:
            return "Name"
        case .lastname:
            return "Lastname"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .passwordConf:
            return "Repeat Password"
        }
    }

    func validate(value: String?) -> Bool {
        guard let value = value else { return false }
        switch self {
        case .name:
            return value.count > 2
        case .lastname:
            return value.count > 2
        case .email:
            return value.count > 6
        case .password:
            return value.count >= 6
        case .passwordConf:
            return value.count >= 6
        }
    }
}

class RegistrationFormViewController: UIViewController {

    struct FormData: Codable {
        let name: String
        let lastname: String
        let email: String
        let password: String
        let passwordConf: String
    }

    struct OptionalFormData: Codable {
        var name: String?
        var lastname: String?
        var email: String?
        var password: String?
        var passwordConf: String?

        var formData: FormData? {
            do {
                let encoded = try JSONEncoder().encode(self)
                return try JSONDecoder().decode(FormData.self, from: encoded)
            } catch let error {
                debugPrint(error)
                return nil
            }
        }
    }

    private var optionalFormData = OptionalFormData()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        
        view.backgroundColor = .white
        view.addSubview(scrollView)

        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

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


        let viewModels = RegistrationField.allCases.map { field in
            return InputFieldViewModel(identifier: field.rawValue,
                                       labelText: NSAttributedString(string: field.label),
                                                placeholder: NSAttributedString(string: field.placeholder),
                                                value: nil) { (updateValue) in
                                                    let fieldValue = RegistrationField(rawValue: field.rawValue)
                                                    guard fieldValue.validate(value: updateValue) else { return }

                                                    switch RegistrationField(rawValue: field.rawValue) {
                                                    case .name:
                                                        self.optionalFormData.name = updateValue
                                                    case .lastname:
                                                        self.optionalFormData.lastname = updateValue
                                                    case .email:
                                                        self.optionalFormData.email = updateValue
                                                    case .password:
                                                        self.optionalFormData.password = updateValue
                                                    case .passwordConf:
                                                        self.optionalFormData.passwordConf = updateValue
                                                    }

                                                    guard let formData = self.optionalFormData.formData else { return  }
                                                    debugPrint("Value of the field changed: \(formData)")

            }
        }

        let buttonViewModel = FormButtonViewModel(identifier: UUID().uuidString,
                                             labelText:  NSAttributedString(string: "Submit")) {
                                                debugPrint("The button was tapped")
        }

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

