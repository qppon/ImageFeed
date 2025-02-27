//
//  ProfileViewPresenterSpy.swift
//  WebViewTests
//
//  Created by Jojo Smith on 2/26/25.
//

import Foundation
import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var didUpdateProfileDetailsCalled: Bool = false
    var didUpdateAvatarCalled: Bool = false
    
    var view: ProfileViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateProfileDetails() -> ImageFeed.Profile? {
        didUpdateProfileDetailsCalled = true
        return nil
    }
    
    func didUpdateAvatar() -> URL? {
        didUpdateAvatarCalled = true
        return nil
    }
    
    func didLogout() {
    }
}
