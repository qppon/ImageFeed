//
//  ProfileViewPresenter.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/26/25.
//

import Foundation
import UIKit

import Foundation

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProfileDetails() -> Profile?
    func didUpdateAvatar() -> URL?
    func didLogout()
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    
    weak var view: ProfileViewControllerProtocol?
    
    
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    
    
    func viewDidLoad() {
        profileImageServiceObserver()
    }
    
    func didUpdateProfileDetails() -> Profile? {
        guard let profile = profileService.profile else {
            print("[ProfileViewPresenter: didUpdateProfileDetails]: Profile was not found")
            return nil
        }
        return profile
    }
    
    func didUpdateAvatar() -> URL? {
        guard let profileImageURL = profileImageService.avatarURL,
              let url = URL(string: profileImageURL)
        else {
            print("[ProfileViewPresenter: didUpdateAvatar]: URL was not found")
            return nil }
        return url
    }
    
    func didLogout() {
        profileLogoutService.logout()
    }
    
    
    private func profileImageServiceObserver() {
        NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            view?.updateAvatar()
        }
    }
}
