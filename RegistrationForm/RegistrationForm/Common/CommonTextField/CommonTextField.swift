//
//  CommonTextField.swift
//  RegistrationForm
//
//  Created by Thorn, David on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class CommonTextField<T: Hashable & CommonTextFieldViewModelProtocol>: UITextField {

    typealias ViewModel = T

    var viewModel: ViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("This method should not be called")
    }

    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(viewModel: ViewModel) {
        self.viewModel = viewModel
        isSecureTextEntry = viewModel.isSecure
        attributedPlaceholder = viewModel.placeholder
        addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
    }

    @objc private func textFieldValueChange(field: UITextField) {
        guard let viewModel = viewModel else { return }
        
        viewModel.textDidChange(field.text, viewModel)
    }

}
