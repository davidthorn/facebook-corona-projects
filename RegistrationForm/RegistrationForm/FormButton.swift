//
//  FormButton.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

protocol FormButtonViewModelProtocol {
    var identifier: String { get }
    var labelText: NSAttributedString { get }
    var tapHandler: () -> Void { get set }
}

struct FormButtonViewModel: FormButtonViewModelProtocol,  Hashable {

    var identifier: String
    var labelText: NSAttributedString
    var tapHandler: () -> Void

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(labelText)
    }

    static func ==(lhs: FormButtonViewModel , rhs: FormButtonViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class FormButton<T: Hashable & FormButtonViewModelProtocol>: UIControl {

    private let label = UILabel()

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

        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])

        addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)

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

}

