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
    private let button = FormButton<FormButtonViewModel>()
    private let buttonWrapper = CommonView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        scrollView.addSubview(stackView)
        buttonWrapper.addSubview(button)

        let buttonHandler: () -> Void = {
            debugPrint("The button was tapped")
        }

        let buttonViewModel = FormButtonViewModel(identifier: UUID().uuidString,
                                                  labelText:  NSAttributedString(string: "Submit"),
                                                  tapHandler: buttonHandler)

        loadData()
        
        button.setup(viewModel: buttonViewModel)

        applyConstraints()

        viewModel.updateViewModels = { viewModelToUpdate in
            self.stackView.arrangedSubviews
                .compactMap { $0 as? InputField<T.FieldViewModel> }
                .filter {
                    if let viewModel = $0.viewModel {
                        return viewModelToUpdate.contains(where: { $0.identifier == viewModel.identifier })
                    }
                    return false
                }
                .forEach { view in
                    guard let viewModel = view.viewModel,
                        let newViewModel = viewModelToUpdate.first(where: { $0.identifier == viewModel.identifier }) else {
                        return
                    }
                    view.setup(viewModel: newViewModel)
                    print(view)
                }

        }
    }

    private func loadData() {

        stackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }

        viewModel.formViewModels.forEach { viewModel in
            let inputField = InputField<T.FieldViewModel>()
            inputField.setup(viewModel: viewModel)
            stackView.addArrangedSubview(inputField)
        }
        stackView.addArrangedSubview(buttonWrapper)

    }

    private func applyConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),

            button.leadingAnchor.constraint(equalTo: buttonWrapper.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: buttonWrapper.trailingAnchor, constant: -15),
            button.topAnchor.constraint(equalTo: buttonWrapper.topAnchor, constant: 15),
            button.bottomAnchor.constraint(equalTo: buttonWrapper.bottomAnchor, constant: -15)
        ])
    }

}
