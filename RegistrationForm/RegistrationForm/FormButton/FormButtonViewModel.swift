//
//  FormButtonViewModel.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

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
