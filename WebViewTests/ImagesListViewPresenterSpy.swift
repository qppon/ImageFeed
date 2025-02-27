//
//  ImagesListViewPresenterSpy.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/27/25.
//
import Foundation

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    func tapLike(for photo: Photo, completion: @escaping (Result<Bool, any Error>) -> Void) {}
    
    var viewDidLoadCalled: Bool = false
    
    var imagesListService: ImagesListServiceProtocol?
    
    var view: ImagesListViewControllerProtocol?
    
    var photos: [ImageFeed.Photo] = []
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateTableViewAnimated() {
    }
    
    func loadImages() {
    }
}
