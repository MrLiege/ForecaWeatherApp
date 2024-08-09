//
//  Token.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

struct Token: Decodable {
    let accessToken: String?
    let tokenType: String?
}
