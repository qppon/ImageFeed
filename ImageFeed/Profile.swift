//
//  ProfileStruct.swift
//  ImageFeed
//
//  Created by Jojo Smith on 1/8/25.
//

import Foundation

public struct Profile {
    let username: String
    let firstName: String
    let lastName: String
    let fullName: String
    let loginName: String
    let bio: String?
    
    init(username: String, firstName: String, lastName: String, bio: String?) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName  + " " + lastName
        self.loginName = "@" + username
        self.bio = bio
    }
}
