//
//  AlertActionConvertible.swift
//  SearchBlogApp
//
//  Created by JIHA YOON on 2022/08/17.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
