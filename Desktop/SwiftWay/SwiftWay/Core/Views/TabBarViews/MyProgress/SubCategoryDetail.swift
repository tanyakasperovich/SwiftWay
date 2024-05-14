//
//  SubCategoryDetail.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct SubCategoryDetail: View {
    var color: Color
    var subCategory: SubCategory
    
    @State var isPremiumUser = false
    
    @State private var showAddNoteView: Bool = false
    @State private var showAddPostView: Bool = false
   // @State var isPresentedQuiz = false
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @StateObject private var viewModel = UserProgressViewModel()
    @State private var isSet: Bool = false
    
    @EnvironmentObject var postViewModel: PostViewModel

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Title, Description.......
                HeaderCardView(color: color, subCategory: subCategory, showAddNoteView: $showAddNoteView, showAddPostView: $showAddPostView, isPremiumUser: $isPremiumUser, isSet: $isSet)
                
                // Posts...
                VStack(alignment: .leading) {
                    SubHeaderText(text: "Posts", color: .secondary)
                        .padding(.horizontal)
                    
                    PostList(posts: postViewModel.posts.filter({$0.subCategoryId == subCategory.id}), userId: profileViewModel.user?.userId ?? "", color: color)
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 5)
            
        }
        .onAppear{
            Task {
                try? await postViewModel.getPosts()
            }
        }
         .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(color: color, showAddNoteView: $showAddNoteView)
        })
         .sheet(isPresented: $showAddPostView, content: {
            //AddNoteView(color: color, showAddNoteView: $showAddNoteView)
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(subCategory.title ?? "")
    }
}

//#Preview {
//    SubCategoryDetail(color: Color.indigo, subCategory:
//                            SubCategory(id: 0, title: "Наследование", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                                                        tests: [
//                                                                            Quiz(title: "Easy Level", description: "", rating: 0.0, questions: [
//                                                                                Question(title: "Question 1", description: "description 3", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 3", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                                                                Question(title: "Question 2", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                                                                Question(title: "Question 3", description: "description 1", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 1", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                                                                Question(title: "Question 4", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: ""))               ]),
//                                                                            Quiz(title: "Medium Level", description: "", rating: 0.0, questions: []),
//                                                                            Quiz(title: "Hard Level", description: "", rating: 0.0, questions: [])
//                                                                        ]))
//    .environmentObject(RoadMapViewModel())
//    .environmentObject(ProfileViewModel())
//}
//
// MARK: - DescriptionCard View...

struct HeaderCardView: View {
    var color: Color
    var subCategory: SubCategory
    @Binding var showAddNoteView: Bool
    @Binding var showAddPostView: Bool
    @Binding var isPremiumUser: Bool
    @Binding var isSet: Bool
    
    var body: some View {
        CardView(content:   
                    VStack {
            HStack(alignment: .top) {
                HeaderText(text: subCategory.title ?? "", color: color)
                
                Spacer()
                
                Button{
                    isSet.toggle()
                } label: {
                    HStack {
                        Image(systemName: isSet ? "checkmark.circle" : "circle")
                            .foregroundColor(isSet ? .green : .red)
                            .bold()
                            .font(.headline)
                    }
                }
            }
            .padding(.vertical)
            
            SmallText(text: subCategory.description ?? "", color: Color.secondary)
            
            HStack {
                NavigationLink {
                    DocumentationWebView(url: subCategory.url)
                } label: {
                    Image(systemName: "doc.text")
                        .padding()
                }
                
                Button{
                    showAddNoteView = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .padding()
                }
                
                
                if isPremiumUser {
                    NavigationLink {
                        BooksView()
                    } label: {
                        Image(systemName: "book.fill")
                            .padding()
                    }
                } else {
                    NavigationLink {
                        // buy premium...
                        Text("Buy Premium...")
                    } label: {
                        ZStack {
                            
                            Image(systemName: "book.fill")
                                .padding()
                                .foregroundColor(.secondary)
                                .opacity(0.5)
                            
                            VStack {
                                Image(systemName: "lock.circle")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                            }
                            .padding(.leading, 30)
                            .padding(.bottom, 30)
                            
                        }
                    }
                }
                
                
                if isPremiumUser {
                    NavigationLink {
                        VideosView()
                    } label: {
                        Image(systemName: "video.fill")
                            .padding()
                    }
                } else {
                    NavigationLink {
                        // buy premium...
                        Text("Buy Premium...")
                    } label: {
                        ZStack {
                            
                            Image(systemName: "video.fill")
                                .padding()
                                .foregroundColor(.secondary)
                                .opacity(0.5)
                            
                            VStack {
                                Image(systemName: "lock.circle")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                            }
                            .padding(.leading, 30)
                            .padding(.bottom, 30)
                            
                        }
                    }
                }
                
            }
            .foregroundColor(color)
            .font(.title2)
            .padding(.top)
            
            HStack {
                Button {
                    showAddPostView = true
                } label: {
                    ButtonView(content: 
                        HeaderText(text: "+ Add New Post", color: Color.theme.fontColorWB)
                        .padding()
                               ,
                               backgroundColor: color)
                }
            }
            .padding(.vertical)
        }
      ,
                 color: color)
    }
}

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

// MARK: - Post ViewModel...
@MainActor
final class PostViewModel: ObservableObject {
    // Posts...
    @Published var posts: [PostModel] = []
    
    // Get Posts...
    func getPosts() async throws {
        //self.posts = try await PostManager.shared.getTips()
        let newPosts = [
            //
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "5ED59E37-A77E-4B7A-851A-CE6B8EC47FC6", subCategoryColor: "", dateCreated: Date(), title: "Post Title 1", description: "Post description description description. Post description description descriptionPost description description description. Post description description description. Post description description description, Post description description description. Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["LkirwY1iFXbouIaS6Vkf2UszSyn1", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "5ED59E37-A77E-4B7A-851A-CE6B8EC47FC6", subCategoryColor: "", dateCreated: Date(), title: "Post Title 2", description: "Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["", "", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            PostModel(userId: "LkirwY1iFXbouIaS6Vkf2UszSyn1", subCategoryId: "FEC05A17-F732-4AE5-90AB-0AB121F9CE57", subCategoryColor: "", dateCreated: Date(), title: "Post Title 3", description: "Post description description description. Post description description description. Post description description description. Post description description description.", likes: ["", "", ""], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())]),
            //
            PostModel(userId: "2", subCategoryId: "FEC05A17-F732-4AE5-90AB-0AB121F9CE57", subCategoryColor: "", dateCreated: Date(), title: "Post Title 1", description: "Post description description description. Post description description description.", likes: ["LkirwY1iFXbouIaS6Vkf2UszSyn1"], comments: [CommentModel(userId: "", userName: "", comment: "Comment Text", dateCreated: Date())])
        ]
        self.posts = newPosts
   }


}
    
struct PostList: View {
    var posts: [PostModel]
    var userId: String
    var color: Color
    
    var body: some View {
        VStack {
            ForEach(posts) { post in
                NavigationLink {
                    PostDetail(post: post, userId: userId, color: color)
                } label: {
                    PostRow(post: post, userId: userId, color: color)
                }
            }

        }
    }
}

struct PostRow: View {
    var post: PostModel
    var userId: String
    var color: Color
    
    var body: some View {
        PostCardView(content:
                        VStack(alignment: .leading) {
            // Title...
            HStack(alignment: .top) {
                HeaderText(text: post.title ?? "", color: Color.theme.fontColor)
                Spacer()
            }
            
            // Author...
            SmallText(text: post.userId ?? "", color: color)
            
            // Description...
            SubHeaderText(text: post.description ?? "", color: Color.theme.fontColorBW)
                    .lineLimit(4)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.leading)
            
            // Likes...
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    HStack {
                        Image(systemName: "message")
                            .bold()
                            .foregroundStyle(Color.theme.fontColor)
                        SmallText(text: "\(post.likes.count)", color: Color.secondary)
                    }
                    .padding(.trailing, 5)
                    
                    HStack {
                        let filteredPosts = post.likes.filter({$0 == userId})
                        Image(systemName: filteredPosts.isEmpty ? "heart" : "heart.fill")
                            .bold()
                            .foregroundStyle(Color.theme.fontColor)
                        SmallText(text: "\(post.likes.count)", color: Color.secondary)
                    }
                }
                .padding(.trailing)
            }
        }
        )
    }
}

struct PostDetail: View {
    var post: PostModel
    var userId: String
    @State var textTextField: String = ""
    @State var authorUserId: String = ""
    var color: Color
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                
                // Author...
                NavigationLink {
                    UserProfileView(userId: authorUserId)
                } label: {
                    HStack {
                        Image(systemName: "circle")
                            .foregroundStyle(color)
                        SmallText(text: post.userId ?? "", color: color)
                    }
                    .padding(.top, 5)
                    .padding(.horizontal)
                    .onAppear{
                        authorUserId = post.userId ?? ""
                    }
                }
                
                // Likes...
                HStack(alignment: .center) {
                    Spacer()
                    HStack(alignment: .center) {
                        Button {
                            
                        } label: {
                            //SmallText(text: "\(post.likes.count)", color: Color.secondary)
                            
                            Image(systemName: "paperplane.fill")
                                .bold()
                        }
                       
                    }
          
                    HStack(alignment: .center) {
                        Button {
                            
                        } label: {
                            SmallText(text: "\(post.likes.count)", color: Color.secondary)
                            
                            Image(systemName: "message")
                                .bold()
                        }
                       
                    }
                    .padding(.leading)
                   
                    HStack(alignment: .center) {
                        Button {
                            
                        } label: {
                            SmallText(text: "\(post.likes.count)", color: Color.secondary)
                            
                            let filteredPosts = post.likes.filter({$0 == userId})
                            Image(systemName: filteredPosts.isEmpty ? "heart" : "heart.fill")
                                .bold()
                        }
                       
                    }
                    .padding(.leading)
                }
                .foregroundStyle(Color.theme.fontColor)
                .padding(.horizontal)
                
                // Description...
                SubHeaderText(text: post.description ?? "", color: Color.theme.fontColorBW)
                    .padding(.horizontal, 8)
                
                // Comments...
                VStack {
                    HStack {
                       TextField("Comment...", text: $textTextField)
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)
                        
                        Button {
                            
                        } label: {
                            PBView(content: Text("Add Comment").padding(5), color: color, isSet: .constant(false))
                        }
                    }
                }
                .padding(.horizontal)
            }
          
       
        }
        .navigationTitle(post.title ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundStyle(color)
                }
                
            }
        }
    }
}

struct CurrentAuthorPostList: View {
    @EnvironmentObject var postViewModel: PostViewModel
    var userId: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(postViewModel.posts.filter({$0.userId == userId})) { post in
                NavigationLink {
                    PostDetail(post: post, userId: userId, color: color)
                } label: {
                    PostRow(post: post, userId: userId, color: color)
                }
            }

        }
    }
}

// MARK: - Documentation Web View...
struct DocumentationWebView: View {
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

//struct DocumentationWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentationWebView(url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics")
//    }
//}

// MARK: - Books View...
struct BooksView: View {
    var body: some View {
        Text("Books View")
    }
}

struct DetailBooksViev: View {
    var body: some View {
        Text("Detail Books View")
    }
}

// MARK: - Videos View...
struct VideosView: View {
    var body: some View {
        Text("Videos View")
    }
}

struct DetailVideosView: View {
    var body: some View {
        Text("Detail Videos View")
    }
}



//struct QuizCardView: View {
//    
//    var color: Color
//    var subCategory: SubCategory
//    var viewModel: UserProgressViewModel
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//          
//            ForEach(subCategory.tests ?? []) { quiz in
////                        let progress = viewModel.userProgress.filter({ item in
////                            item.quizId == quiz.id
////                        })
////
////                        let lastProgressId = progress.last?.id ?? ""
////                        let lastProgressScore = progress.last?.quizScore ?? 0
////                       // let lastProgressRating =
//                
//                VStack(alignment: .leading) {
//                    Text(quiz.title ?? "")
//                        .font(.callout)
//                        .foregroundColor(.secondary)
//                    
//
//                    Button {
//                        viewModel.isPresentedQuiz = true
//                    } label: {
//                        ZStack {
//                            RoundedRectangleShape(color: color)
//                                .frame(height: 55)
//                                .opacity(0.3)
//                            
//                            Text(quiz.id)
//                            
////                                    Text("\(lastProgressScore, specifier: "%.0f") %")
////                                        .foregroundStyle(.white)
////                                        .bold()
////                                    Text("\(quiz.rating ?? 0.0, specifier: "%.0f") %")
////                                        .foregroundStyle(.white)
////                                        .bold()
//                        }
//                    }
//                }
//                .fullScreenCover(isPresented: $viewModel.isPresentedQuiz, content: {
//                    QuizView(viewModel: viewModel, color: color, quiz: quiz, subCategoryId: subCategory.id)
//                })
//            }
//        }
//        .padding(.horizontal)
//    }
//}

//struct ProgressListView: View {
//    
//    var color: Color
//    var subCategory: SubCategory
//    var viewModel: UserProgressViewModel
//    
//    var body: some View {
//        
//        VStack {
//            HStack {
//                Text("Progress: \(subCategory.rating ?? 0.0, specifier: "%.0f")%").foregroundColor(color)
//                    .padding()
//                Spacer()
//            }
//            
//            
//            VStack {
//                let subCategoryProgress = viewModel.userProgress.filter({ item in
//                    item.subCategoryId == subCategory.id
//                })
//                
//                //                    let quizProgress = subCategoryProgress.filter({item in
//                //                        item.quizId == quiz.id
//                //                    })
//                
//                ForEach(subCategoryProgress) { item in
//                    
//                    HStack {
//                        Text(item.quizId)
//                        Spacer()
//                        Text("\(item.quizScore)")
//                    }
//                    .contextMenu {
//                        Button("Remove from my progress") {
//                            viewModel.removeUserProgress(progressId: item.id)
//                        }
//                    }
//                    
//                }
//                
//            }
//            .onAppear {
//                viewModel.getAllUserProgress()
//            }
//        }
//    }
//}
