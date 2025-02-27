//
//  Photo.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/7/25.
//

import Foundation

public struct Photo {
    private static let dateFormatter: ISO8601DateFormatter = {
       ISO8601DateFormatter()
    }()
    
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    var isLiked: Bool
    
    init(photoResult: PhotoResult) {
        id = photoResult.id
        size = CGSize(width: photoResult.width, height: photoResult.height)
        createdAt = Photo.dateFormatter.date(from: photoResult.createdAt)
        welcomeDescription = photoResult.description
        thumbImageURL = photoResult.urls.thumb
        largeImageURL = photoResult.urls.full
        isLiked = photoResult.isLiked
    }
}
