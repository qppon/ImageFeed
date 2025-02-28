//
//  ImagesListViewControllerSpy.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/27/25.
//

@testable import ImageFeed
import Foundation

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    
    var didUpdateTableViewAnimatedCalled: Bool = false
    
    var presenter: ImagesListViewPresenterProtocol?
    
    var oldCount: Int = 0
    
    var newCount: Int = 0
    
    func updateTableViewAnimated() {
        didUpdateTableViewAnimatedCalled = true
    }
}
