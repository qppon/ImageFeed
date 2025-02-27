//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/1/25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewPresenter = ImagesListViewPresenter()
        guard let imageListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as? ImagesListViewController else {
            assertionFailure("ImagesListViewController не найден в сториборде")
            return
        }
        imageListViewController.presenter = imagesListViewPresenter
        imagesListViewPresenter.view = imageListViewController
        
        
        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfileViewPresenter()
        profileViewController.presenter = profileViewPresenter
        profileViewPresenter.view = profileViewController
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .tabProfileActive),
            selectedImage: nil
        )
        self.viewControllers = [imageListViewController, profileViewController]
    }
}
