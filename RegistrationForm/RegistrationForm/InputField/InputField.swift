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
    private let textField = UITextField()
    private let stackView = UIStackView()

    var viewModel: ViewModel?

    typealias ViewModel = T

    override func commonInit() {
        super.commonInit()
        
        label.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)

        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 3

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)

        textField.backgroundColor = .yellow
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
    }

    func setup(viewModel: ViewModel) {
        guard viewModel != self.viewModel else { return }

        self.viewModel = viewModel

        label.attributedText = viewModel.labelText
        textField.attributedPlaceholder = viewModel.placeholder
        textField.text = viewModel.value
    }

    @objc private func textFieldDidChange(field: UITextField) {
        guard let viewModel = viewModel else { return }

        viewModel.textDidChange(field.text, viewModel)
    }

}

