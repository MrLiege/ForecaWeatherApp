//
//  UserStorage.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

struct UserStorage {
    static var shared = UserStorage()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Access Token
    var token: String? {
        get {
            defaults.string(forKey: UserStorageKey.token.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: UserStorageKey.token.rawValue)
        }
    }
}

enum UserStorageKey: String {
    case token
    case login
    case password
}
