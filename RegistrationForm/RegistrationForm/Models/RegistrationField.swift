//
//  RegistrationField.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

enum RegistrationField: String, CaseIterable{

    init(rawValue: String) {
        switch rawValue {
        case RegistrationField.name.rawValue:
            self = .name
        case RegistrationField.lastname.rawValue:
            self = .lastname
        case RegistrationField.email.rawValue:
            self = .email
        case RegistrationField.password.rawValue:
            self = .password
        case RegistrationField.passwordConf.rawValue:
            self = .passwordConf
        default:
            fatalError("Invalid field type")
        }
    }

    case name
    case lastname
    case email
    case password
    case passwordConf

    var placeholder: String {
        switch self {
        case .name:
            return "Enter your name"
        case .lastname:
            return "Enter your lastname"
        case .email:
            return "Enter your email"
        case .password:
            return "Enter your password"
        case .passwordConf:
            return "Confirm your password"
        }
    }

    var label: String {
        switch self {
        case .name:
            return "Name"
        case .lastname:
            return "Lastname"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .passwordConf:
            return "Repeat Password"
        }
    }

    func validate(value: String?) -> Bool {
        guard let value = value else { return false }
        switch self {
        case .name:
            return value.count > 7
        case .lastname:
            return value.count > 2
        case .email:
            return value.count > 6
        case .password:
            return value.count >= 6
        case .passwordConf:
            return value.count >= 6
        }
    }

    var isSecure: Bool {
        switch self {
        case .password, .passwordConf:
            return true
        default:
            return false 
        }
    }
}
