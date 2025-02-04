//
//  ProfileStruct.swift
//  ImageFeed
//
//  Created by Jojo Smith on 1/8/25.
//

import Foundation

struct Profile {
    let username: String
    let firstName: String
    let lastName: String
    let fullName: String
    let loginName: String
    let bio: String?
    
    init(usename: String, firstName: String, lastName: String, bio: String?) {
        self.username = usename
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName  + " " + lastName
        self.loginName = "@" + usename
        self.bio = bio
    }
}
