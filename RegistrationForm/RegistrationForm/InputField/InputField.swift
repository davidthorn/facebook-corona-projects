//
//  InputField.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class InputField<T: Hashable & InputFieldViewModelProtocol>: CommonView {

    private let label = UILabel()
    private let textField = CommonTextField<T.TextFieldViewModel>()
    private let textFieldWrapper = BorderCommonView()
    private let stackView = UIStackView()

    var viewModel: ViewModel?

    typealias ViewModel = T

    override func commonInit() {
        super.commonInit()
        
        label.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textFieldWrapper.addSubview(textField)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textFieldWrapper)
        addSubview(stackView)
        applyConstraints()
    }

    func setup(viewModel: ViewModel) {
        guard viewModel != self.viewModel else { return }

        self.viewModel = viewModel

        label.attributedText = viewModel.labelText
        textField.setup(viewModel: viewModel.textFieldViewModel)
    }

    private func applyConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: textFieldWrapper.leadingAnchor, constant: 6),
            textField.trailingAnchor.constraint(equalTo: textFieldWrapper.trailingAnchor, constant: -6),
            textField.topAnchor.constraint(equalTo: textFieldWrapper.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: textFieldWrapper.bottomAnchor, constant: 0)
        ])
    }
}

