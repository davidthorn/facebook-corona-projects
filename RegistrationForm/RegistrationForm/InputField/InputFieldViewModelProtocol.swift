//
//  InputFieldViewModelProtocol.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

protocol InputFieldViewModelProtocol {
    var identifier: String { get }
    var labelText: NSAttributedString { get }
    var placeholder: NSAttributedString { get }
    var value: String? { get }
    var textDidChange: (_ value: String?, _ viewModel: InputFieldViewModelProtocol) -> Void { get set }
}
