//
//  FilterViewModel.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/24.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
