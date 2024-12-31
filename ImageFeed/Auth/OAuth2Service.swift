//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Jojo Smith on 12/24/24.
//

import Foundation

final class OAuth2Service {
    static let shared = OAuth2Service()
    private let storage = OAuth2TokenStorage()
    private init() {}
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com"),
              let url = URL(
                string: "/oauth/token"
                + "?client_id=\(Constants.accessKey)"
                + "&&client_secret=\(Constants.secretKey)"
                + "&&redirect_uri=\(Constants.redirectURI)"
                + "&&code=\(code)"
                + "&&grant_type=authorization_code",
                relativeTo: baseURL
              ) else {
            print("Error makeTokenRequest baseURL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOauthToken(code: String, handler: @escaping (Result<String, Error>) -> Void) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Error makeTokenRequest")
            return
        }
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let oauthTokenResponseBody = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    self.storage.bearerToken = oauthTokenResponseBody.accessToken
                    handler(.success(oauthTokenResponseBody.accessToken))
                } catch {
                    print(error)
                    handler(.failure(error))
                }
            case .failure(let error):
                print(error)
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
