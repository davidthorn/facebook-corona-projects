//
//  RegistrationOptionalFormData.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct RegistrationOptionalFormData: Codable, Hashable {
    var name: String?
    var lastname: String?
    var email: String?
    var password: String?
    var passwordConf: String?

    var formData: RegistrationFormData? {
        do {
            let encoded = try JSONEncoder().encode(self)
            return try JSONDecoder().decode(RegistrationFormData.self, from: encoded)
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
}
