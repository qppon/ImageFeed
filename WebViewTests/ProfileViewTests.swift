//
//  ProfileViewTests.swift
//  WebViewTests
//
//  Created by Jojo Smith on 2/26/25.
//

import Foundation

import XCTest
@testable import ImageFeed

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenterSpy = ProfileViewPresenterSpy()
        profileViewController.presenter = profileViewPresenterSpy
        profileViewPresenterSpy.view = profileViewController
        
        //when
        _ = profileViewController.view
        
        //then
        XCTAssertTrue(profileViewPresenterSpy.viewDidLoadCalled)
    }
    
    func testViewControllerCallsDidUpdateProfileDetails() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenterSpy = ProfileViewPresenterSpy()
        profileViewController.presenter = profileViewPresenterSpy
        profileViewPresenterSpy.view = profileViewController
        
        //when
        _ = profileViewController.view
        
        //then
        XCTAssertTrue(profileViewPresenterSpy.didUpdateProfileDetailsCalled)
    }
    
    func testViewControllerCallsDidUpdateAvatar() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenterSpy = ProfileViewPresenterSpy()
        profileViewController.presenter = profileViewPresenterSpy
        profileViewPresenterSpy.view = profileViewController
        
        //when
        profileViewController.updateAvatar()
        
        //then
        XCTAssertTrue(profileViewPresenterSpy.didUpdateAvatarCalled)
    }
}
