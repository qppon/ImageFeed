//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Jojo Smith on 2/7/25.
//

import Foundation

final class ImagesListService {
    private(set) var photos: [Photo] = []
    
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    func fetchPhotosNextPage() {
        assert(Thread.isMainThread)
        guard task == nil else {
            print("extra task in imageListService")
            return
        }
        task?.cancel()
        
        let nextPage = (lastLoadedPage ?? 0) + 1
        
        guard let request = makeImageListRequest(nextPage: nextPage) else {
            print("invalid request in ImagesListService")
            return
        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            switch result {
            case .success(let photosResult):
                for photoResult in photosResult {
                    let photo = Photo(photoResult: photoResult)
                    self?.photos.append(photo)
                }
                NotificationCenter.default.post(name: Self.didChangeNotification, object: self)
                self?.lastLoadedPage = nextPage
            case .failure(let error):
                print("ImagesListService: network or request error: \(error.localizedDescription)")
            }
            self?.task = nil
        }
        self.task = task
        task.resume()
    }
    
    
    private func makeImageListRequest(nextPage: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/photos" + "?page=\(nextPage)"),
              let token = OAuth2TokenStorage.shared.bearerToken
        else {
            assertionFailure("ImagesListService: Failed to create URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        lastLoadedPage = nextPage
        return request
    }
}
