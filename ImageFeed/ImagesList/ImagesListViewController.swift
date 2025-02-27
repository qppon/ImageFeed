//
//  ViewController.swift
//  ImageFeed
//
//  Created by Jojo Smith on 10/29/24.
//

import UIKit

public protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: ImagesListViewPresenterProtocol? { get set }
    var oldCount: Int { get set }
    var newCount: Int { get set }
    func updateTableViewAnimated()
}

class ImagesListViewController: UIViewController & ImagesListViewControllerProtocol {
    
    
    var presenter: ImagesListViewPresenterProtocol?
    var oldCount: Int = 0
    var newCount: Int = 0
    
    @IBOutlet private var tableView: UITableView!
    
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private var imageListService = ImagesListService.shared
    
    private var photos: [Photo] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    func updateTableViewAnimated() {
        photos = imageListService.photos
        if oldCount != newCount {
            tableView.performBatchUpdates {
                let indexPaths = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPaths, with: .automatic)
            } completion: { _ in }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                assertionFailure("Invalid segue destination")
                return
            }
            
            guard let photo = presenter?.photos[indexPath.row] else {
                assertionFailure("photo is empty")
                return
            }
            guard !photo.largeImageURL.isEmpty, let url = URL(string: photo.largeImageURL) else {
                assertionFailure("Invalid or empty URL for image")
                return
            }
            viewController.imageURL = url
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        presenter?.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let photo = presenter?.photos else { return }
        if indexPath.row + 1 == photo.count {
            presenter?.loadImages()
        }
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let photo = presenter?.photos[indexPath.row] else { return }
        
        if let url = URL(string: photo.largeImageURL) {
            
            cell.cellImage.kf.indicatorType = .activity
            let placeholder = UIImage(resource: .placeholder)
            cell.cellImage.contentMode = .center
            
            cell.cellImage.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: nil,
                progressBlock: nil
            ) { [weak self] result in
                switch result {
                case .success:
                    
                    DispatchQueue.main.async {
                        cell.cellImage.contentMode = .scaleAspectFill
                        self?.tableView.beginUpdates()
                        self?.tableView.endUpdates()
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
            cell.dateLabel.text = dateFormatter.string(from: Date())
            
            let likeImage = UIImage(resource: photo.isLiked ? .likeButtonOn : .likeButtonOff)
            cell.likeButton.setImage(likeImage, for: .normal)
        }
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        imageListCell.delegate = self
        
        return imageListCell
    }
}


extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let photo = presenter?.photos[indexPath.row] else { return }
        
        UIBlockingProgressHUD.show()
        
        presenter?.tapLike(for: photo) { [weak self] result in
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                switch result {
                case .success(let isLiked):
                    self?.presenter?.photos[indexPath.row].isLiked = isLiked
                    cell.setIsLiked(isLiked: isLiked)
                case .failure:
                    print("Error changing like state")
                }
            }
        }
    }
}


extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = presenter?.photos[indexPath.row] else { return 1 }
        _ = URL(string: image.largeImageURL)
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageWidth != 0 ? imageViewWidth / imageWidth : 0
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
}

