//
//  SearchDKBlogNetwork.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/17.
//

import Foundation
import RxSwift

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

class SearchDKBlogNetwork {
    private let session: URLSession
    let api = SearchDKBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchDKBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchDKBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 68168a239cadcd3303b446904d5df64e", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
