//
//  BlogListViewModel.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/24.
//

import RxSwift
import RxCocoa

struct BlogViewListModel {
    let filterViewModel = FilterViewModel()
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
