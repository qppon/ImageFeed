//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Jojo Smith on 11/7/24.
//
import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    var delegate: ImagesListCellDelegate?
    
    
    @IBAction private func didTapLikeButton(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
    }
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    func configCell(_ image: UIImage, _ date: String, _ liked: Bool) {
        self.selectionStyle = .none
        let buttonImage = liked ? UIImage(named: "likeButtonOff") : UIImage(named: "likeButtonOn")
        self.likeButton.setImage(buttonImage, for: .normal)
        self.cellImage.image = image
        self.dateLabel.text = date
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.kf.cancelDownloadTask()
    }
    
    func setIsLiked(isLiked: Bool) {
        likeButton.setImage(UIImage(named: isLiked ? "likeButtonOn" : "likeButtonOff"), for: .normal)
    }
}
