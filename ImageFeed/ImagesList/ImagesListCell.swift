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
    
    func configCell(_ image: UIImage, _ date: String, _ liked: Bool) {
        
        let buttonImage = liked ? UIImage(named: "liked_button_off") : UIImage(named: "liked_button_on")
        self.likeButton.setImage(buttonImage, for: .normal)
        self.cellImage.image = image
        self.dateLabel.text = date
    }
}
