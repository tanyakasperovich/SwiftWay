//
//  DetailSubCategoryView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

// MARK: - Detail SubCategory View...
/*
 |DetailSubCategoryView -> DocumentationWebView|,
 |DetailSubCategoryView 🔃 AddNoteView|,
 |DetailSubCategoryView -> BooksViev//Buy Premium..|,
 |DetailSubCategoryView -> VideosViev//Buy Premium..|,
 |DetailSubCategoryView -> TestViev//Buy Premium..|
 */

struct DetailSubCategoryView: View {
    var color: Color
    var subCategory: SubCategory
    
    @State var isPremiumUser = false
    
    @State private var showAddNoteView: Bool = false
    
   // @State var isPresentedQuiz = false
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @StateObject private var viewModel = UserProgressViewModel()
        
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Title, Description.......
               DescriptionCardView(color: color, subCategory: subCategory, showAddNoteView: $showAddNoteView, isPremiumUser: $isPremiumUser)

                // Quiz...
                        VStack(alignment: .leading) {
                
                            ForEach(subCategory.tests ?? []) { quiz in
                
                                VStack(alignment: .leading) {
                                    Text(quiz.title ?? "")
                                        .font(.callout)
                                        .foregroundColor(.secondary)
                                    
//                                    NavigationLink {
//                                 
//                                                                            } label: {
//                                                                                ZStack {
//                                                                                    RoundedRectangleShape(color: color)
//                                                                                        .frame(height: 55)
//                                                                                        .opacity(0.3)
//                                    
//                                                                                    Text(quiz.id)
//                                                                                }
//                                                                            }
                                        Button {
                                            if quiz.title == "Easy Level" {
                                                viewModel.isPresentedEasyLevelQuiz = true
                                            }
                                            if quiz.title == "Medium Level" {
                                                viewModel.isPresentedMediumLevelQuiz = true
                                            }
                                            if quiz.title == "Hard Level" {
                                                viewModel.isPresentedHardLevelQuiz = true
                                            }
                                        } label: {
                                            ZStack {
                                                RoundedRectangleShape(color: color)
                                                    .frame(height: 55)
                                                    .opacity(0.3)
                                                
                                                Text(quiz.id)
                                            }
                                        }
           
                                }
                                .fullScreenCover(isPresented: $viewModel.isPresentedEasyLevelQuiz, content: {
                                    QuizView(viewModel: viewModel, color: color, quiz: quiz, subCatedoryId: subCategory.id)
                                })
                                .fullScreenCover(isPresented: $viewModel.isPresentedMediumLevelQuiz, content: {
                                    QuizView(viewModel: viewModel, color: color, quiz: quiz, subCatedoryId: subCategory.id)
                                })
                                .fullScreenCover(isPresented: $viewModel.isPresentedHardLevelQuiz, content: {
                                    QuizView(viewModel: viewModel, color: color, quiz: quiz, subCatedoryId: subCategory.id)
                                })
                            }
                        }
                        .padding(.horizontal)

                // Progress........
                VStack {
                    HStack {
                        Text("Progress: \(subCategory.rating ?? 0.0, specifier: "%.0f")%").foregroundColor(color)
                            .padding()
                        Spacer()
                    }
                    
                    
                    VStack {
                        let subCategoryProgress = viewModel.userProgress.filter({ item in
                            item.subCategoryId == subCategory.id
                        })
                        
                        //                    let quizProgress = subCategoryProgress.filter({item in
                        //                        item.quizId == quiz.id
                        //                    })
                        
                        ForEach(subCategoryProgress) { item in
                            
                            HStack {
                                Text(item.quizId)
                                Spacer()
                                Text("\(item.quizScore)")
                            }
                            .contextMenu {
                                Button("Remove from my progress") {
                                    viewModel.removeUserProgress(progressId: item.id)
                                }
                            }
                            
                        }
                        
                    }
                    .onAppear {
                        viewModel.getAllUserProgress()
                    }
                }
               // ProgressListView(color: color, subCategory: subCategory, viewModel: viewModel)
               
            }
            .padding(.horizontal, 10)
            
            
        }
        .background(BackgroundView(color: color))
        .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(color: Color.accentColor, showAddNoteView: $showAddNoteView)
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(subCategory.title ?? "")
    }
}

//#Preview {
//    DetailSubCategoryView(color: Color.indigo, subCategory:
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

//struct BooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksView()
//    }
//}

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

//struct VideosView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideosView()
//    }
//}

struct DetailVideosView: View {
    var body: some View {
        Text("Detail Videos View")
    }
}

// MARK: -  View...
struct DescriptionCardView: View {
    
    var color: Color
    var subCategory: SubCategory
    @Binding var showAddNoteView: Bool
    @Binding var isPremiumUser: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangleShape(color: color)
            
            ZStack {
                RoundedRectangleShape(color: .white)
                    .opacity(0.9)
                
                VStack {
                    HStack {
                        
                        Spacer()
                        Text(subCategory.title ?? "")
                        
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "heart")
                                .foregroundColor(.pink)
                        }
                        
                        
                    }
                    .font(.title2)
                    .bold()
                    .foregroundColor(color)
                    .padding(.vertical)
                    
                    Text(subCategory.description ?? "")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    
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
                    .padding(.vertical)
                }
                .padding()
            }
            .padding(30)
        }
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

struct ProgressListView: View {
    
    var color: Color
    var subCategory: SubCategory
    var viewModel: UserProgressViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Progress: \(subCategory.rating ?? 0.0, specifier: "%.0f")%").foregroundColor(color)
                    .padding()
                Spacer()
            }
            
            
            VStack {
                let subCategoryProgress = viewModel.userProgress.filter({ item in
                    item.subCategoryId == subCategory.id
                })
                
                //                    let quizProgress = subCategoryProgress.filter({item in
                //                        item.quizId == quiz.id
                //                    })
                
                ForEach(subCategoryProgress) { item in
                    
                    HStack {
                        Text(item.quizId)
                        Spacer()
                        Text("\(item.quizScore)")
                    }
                    .contextMenu {
                        Button("Remove from my progress") {
                            viewModel.removeUserProgress(progressId: item.id)
                        }
                    }
                    
                }
                
            }
            .onAppear {
                viewModel.getAllUserProgress()
            }
        }
    }
}
