//
//  MainViewModel.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/24.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let blogListViewModel = BlogViewListModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchDKBlog)
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getDKBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getDKBlogError)
        
        // network result transforming cell data
        let cellData = blogValue
            .map(model.getBlogListCellData)
        
        // alertsheet type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // ViewController -> ListView
        Observable
            .combineLatest(sortedType, cellData, resultSelector: model.sort)
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)
        
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (title: "OOPS!", message: "Unexpected error occurred! \(message)", actions: [.confirm], style: .alert)
            }
        self.shouldPresentAlert =
        Observable
            .merge(alertSheetForSorting, alertForErrorMessage)
            .asSignal(onErrorSignalWith: .empty())
    }
    
    
    
}
