//
//  PostModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 28.05.24.
//

import Foundation

// MARK: - Post Model...
struct PostModel: Identifiable, Codable {
    var id = UUID().uuidString
    let userId: String?
    let subCategoryId:  String?
    let subCategoryColor: String?
    let dateCreated: Date?
    let title: String?
    let description: String?
    let likes: [String?]
    let comments: [CommentModel]
}

struct CommentModel: Identifiable, Codable {
    var id = UUID().uuidString
    let userId:  String?
    let userName:  String?
    let comment:  String?
    let dateCreated: Date?
}
