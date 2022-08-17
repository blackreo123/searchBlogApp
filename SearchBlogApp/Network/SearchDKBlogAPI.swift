//
//  SearchDKBlogAPI.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/17.
//

import Foundation

struct SearchDKBlogAPI {
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/search/"
    
    func searchDKBlog(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = SearchDKBlogAPI.scheme
        components.host = SearchDKBlogAPI.host
        components.path = SearchDKBlogAPI.path + "blog"
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        return components
    }
}
