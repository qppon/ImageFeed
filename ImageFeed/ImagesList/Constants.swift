//
//  Constants.swift
//  ImageFeed
//
//  Created by Jojo Smith on 11/22/24.
//

import Foundation

enum Constants {
    static let accessKey = "pxDaWkuSHlfyOolAcvwQU9NZlqqJUvpN7X0ITXQJqbc"
    static let secretKey = "TgVg8v-0-vGyiHN-HkYXMMf3-omTDE1wGlZYr2F9i9o"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
}
