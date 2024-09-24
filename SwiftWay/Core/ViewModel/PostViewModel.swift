//
//  PostViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 28.05.24.
//

import Foundation

// MARK: - Post ViewModel...
@MainActor
final class PostViewModel: ObservableObject {
    // Posts...
    @Published var posts: [PostModel] = []
    
    // Get Posts...
    func getPosts() async throws {
        //self.posts = try await PostManager.shared.getPosts()
        let newPosts = [
            //
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "5ED59E37-A77E-4B7A-851A-CE6B8EC47FC6", subCategoryColor: "", dateCreated: Date(), title: "Post Title 1", description: "Post description description description. Post description description descriptionPost description description description. Post description description description. Post description description description, Post description description description. Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["LkirwY1iFXbouIaS6Vkf2UszSyn1", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "5ED59E37-A77E-4B7A-851A-CE6B8EC47FC6", subCategoryColor: "", dateCreated: Date(), title: "Post Title 2", description: "Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["", "", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "FEC05A17-F732-4AE5-90AB-0AB121F9CE57", subCategoryColor: "", dateCreated: Date(), title: "Post Title 3", description: "Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["", "", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            //
            PostModel(userId: "2", subCategoryId: "FEC05A17-F732-4AE5-90AB-0AB121F9CE57", subCategoryColor: "", dateCreated: Date(), title: "Post Title 1", description: "Post description description description. Post description description description.", likes: ["LkirwY1iFXbouIaS6Vkf2UszSyn1"], comments: [])
        ]
        self.posts = newPosts
   }


}
 
