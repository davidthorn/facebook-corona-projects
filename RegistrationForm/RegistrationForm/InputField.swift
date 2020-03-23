//
//  InputField.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

protocol InputFieldViewModelProtocol {
    var identifier: String { get }
    var labelText: NSAttributedString { get }
    var placeholder: NSAttributedString { get }
    var value: String? { get }
    var textDidChange: (String?) -> Void { get set }
}

struct InputFieldViewModel: InputFieldViewModelProtocol,  Hashable {

    var identifier: String
    var labelText: NSAttributedString
    var placeholder: NSAttributedString
    var value: String?
    var textDidChange: (String?) -> Void

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

class InputField<T: Hashable & InputFieldViewModelProtocol>: UIView {

    private let label = UILabel()
    private let textField = UITextField()
    private let stackView = UIStackView()

    var viewModel: ViewModel?

    typealias ViewModel = T

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {

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
        viewModel?.textDidChange(field.text )
    }

}

