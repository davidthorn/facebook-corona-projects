//
//  RegistrationFormData.swift
//  RegistrationForm
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import Foundation

struct RegistrationFormData: Codable, Hashable {
    let name: String
    let lastname: String
    let email: String
    let password: String
    let passwordConf: String
}
