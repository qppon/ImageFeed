//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Jojo Smith on 11/7/24.
//
import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
}
