//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Jojo Smith on 12/29/24.
//

import UIKit

final class OAuth2TokenStorage {
    private let storage: UserDefaults = .standard
    
    var bearerToken: String? {
        get {
            storage.string(forKey: "bearerToken")

        }
        set {
            storage.set(newValue, forKey: "bearerToken")
        }
    }
}
