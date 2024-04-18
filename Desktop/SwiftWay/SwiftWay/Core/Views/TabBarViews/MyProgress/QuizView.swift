//
//  QuizView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 12.01.24.
//

import SwiftUI

// MARK: - Quiz Viev...
struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    // @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    var viewModel: UserProgressViewModel
    
    @State var showAlert: Bool = false
    
    var color: Color
    var quiz: Quiz
    var subCatedoryId: String
    // var progressId: String
    
    var body: some View {
        VStack {
            // Button Dismiss...
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                    viewModel.currentQuestionIndex = 0
                    viewModel.isCorrectAnswer = false
                    viewModel.userScore = 0
                    viewModel.selectedAnswer = ""
                    viewModel.progress = 0.00
                    viewModel.isPresentedQuiz = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(color)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            // Progress Bar...
            //                          VStack {
            //                                ProgressBar(progress: viewModel.progress, color: color)
            //                            }
            //                            .padding(.bottom)
            ProgressBar(progress: viewModel.progress, color: color)
                .padding(.bottom)
            
            Text(quiz.id)
                .padding()
            
//            // Quiz...
//            // Question...
            CardView(content:
                        VStack {
                Text(quiz.questions?[viewModel.currentQuestionIndex].title ?? "")
                    .bold()
                    .padding(5)
                Text(quiz.questions?[viewModel.currentQuestionIndex].description ?? "")
                
                Spacer()
            }, color: color)
            
//            // Answers...
            
            ScrollView {
                ForEach(quiz.questions?[viewModel.currentQuestionIndex].answers ?? [], id: \.self) { answer in
                    Button(action: {
                        viewModel.checkAnswer(answer, quiz: quiz)
                    }) {
                        VStack (alignment: .leading) {
                            
                            HStack(spacing: 20) {
                                Image(systemName: viewModel.selectedAnswer == answer ? (viewModel.isCorrectAnswer ? "checkmark.circle" : "xmark.circle") : "circle")
                                    .bold()
                                Text(answer)
                            }
                            .padding()
                            .foregroundColor(viewModel.selectedAnswer == answer  ? (viewModel.isCorrectAnswer ? Color.green : Color.red) : Color.black)
                            
                            Divider()
                        }
                    }
                    .disabled(viewModel.isCorrectAnswer)
                }
            }
            .padding(.horizontal)
            
            // Button NEXT...
            if let lastQuestion = quiz.questions?.last, lastQuestion.id == quiz.questions?[viewModel.currentQuestionIndex].id {
                // Alert.....
                Button {
                    let progress = viewModel.userProgress.filter({ item in
                            item.quizId == quiz.id
                        })
                        
                        let lastProgressId = progress.last?.id ?? ""
                    
                    viewModel.updateUserProgress(progressId: lastProgressId, quizScore: viewModel.userScore)
                    showAlert = true
                    // update progress........
                } label: {
                    HStack {
                        Text("CHECK")
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(
                        RoundedRectangleShape(color: color) .shadow(color: .black.opacity(0.6), radius: 1, x: 0, y: 2))
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.isCorrectAnswer)
                .padding(.horizontal)
                .padding()
                
            } else {
                Button {
                    viewModel.nextQuestion(quiz: quiz)
                    
                    if viewModel.userScore == 1 {
                        viewModel.addUserProgress(progress: UserProgress(dateCreated: Date.now, levelId: "", categoryId: "", subCategoryId: subCatedoryId, quizId: quiz.id, quizScore: viewModel.userScore))
                    }
                    if viewModel.userScore > 1 {
                            
                        let progress = viewModel.userProgress.filter({ item in
                                item.quizId == quiz.id
                            })
                            
                            let lastProgressId = progress.last?.id ?? ""
                        
                        
                        // update progress........
                      viewModel.updateUserProgress(progressId: lastProgressId, quizScore: viewModel.userScore)
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.right")
                                .opacity(0.8)
                        Image(systemName: "chevron.right")
                            .opacity(0.7)
                        Image(systemName: "chevron.right")
                            .opacity(0.6)
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(
                        RoundedRectangleShape(color: color) .shadow(color: .black.opacity(0.6), radius: 1, x: 0, y: 2))
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.isCorrectAnswer)
                .padding(.horizontal)
                .padding()
                
            }
            
            // Score...
            HStack {
                Text("Score: \(viewModel.userScore)")
                    .foregroundStyle(Color.secondary)
                
                Spacer()
            }
            .padding(.horizontal, 5)
        }
        .padding(.horizontal)
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Score: \(viewModel.userScore)"),
                message: Text("alertMessage"),
                dismissButton: .default(Text("OK"))
            )
            
        })
    }
}

//#Preview {
//    QuizView(color: Color.accentColor, viewModel: <#UserProgressViewModel#>, quiz: Quiz(title: "Easy Level", description: "", rating: 0.0, questions: [
//        Question(title: "Question 1", description: "description 3", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 3", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//        Question(title: "Question 2", description: "description description description description description description description description description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4", "Answer 5", "Answer 6"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//        Question(title: "Question 3", description: "description 1", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 1", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//        Question(title: "Question 4", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//    ]), progressId: "")
//    //  .environmentObject(UserProgressViewModel())
//}
