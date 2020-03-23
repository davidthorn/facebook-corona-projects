//
//  CommonTextFieldViewModelProtocol.swift
//  RegistrationForm
//
//  Created by Thorn, David on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

protocol CommonTextFieldViewModelProtocol {
    var identifier: String { get }
    var value: String? { get }
    var isSecure: Bool { get }
    var placeholder: NSAttributedString { get }
    var textDidChange: (_ value: String?, _ viewModel: CommonTextFieldViewModelProtocol) -> Void { get set }

    init(identifier: String,
         value: String?,
         isSecure: Bool,
         placeholder: NSAttributedString,
         textDidChange: @escaping (_ value: String?, _ viewModel: CommonTextFieldViewModelProtocol) -> Void)
}
