//
//  FormButton.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class FormButton<T: Hashable & FormButtonViewModelProtocol>: CommonControl {

    private let label = UILabel()

    var viewModel: ViewModel?

    typealias ViewModel = T

    override func commonInit() {
        super.commonInit()
        
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        addSubview(label)
        addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        applyConstraints()
    }

    func setup(viewModel: ViewModel) {
        guard viewModel != self.viewModel else { return }

        self.viewModel = viewModel
        label.attributedText = viewModel.labelText
    }

    @objc private func buttonWasTapped(sender: UIControl) {
        viewModel?.tapHandler()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 5
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        backgroundColor = .systemBlue
        label.textColor = .white
    }

    private func applyConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }

}

