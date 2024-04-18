//
//  ProgressViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 12.01.24.
//

import SwiftUI

@MainActor
final class UserProgressViewModel: ObservableObject {
    //  User Progress...
    @Published private(set) var userProgress: [UserProgress] = []
    
    // Quiz....
    @Published var isPresentedQuiz = false
    @Published var isPresentedEasyLevelQuiz = false
    @Published var isPresentedMediumLevelQuiz = false
    @Published var isPresentedHardLevelQuiz = false

    //  let questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var userScore = 0
    @Published var isCorrectAnswer = false
    @Published var selectedAnswer = ""
    @Published var progress: CGFloat = 0.00
    @Published private(set) var length = 0
    @Published var progressId = ""
    
    func addUserProgress(progress: UserProgress) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.addUserProgress(userId: authDataResult.uid, progress: progress)
        }
        getAllUserProgress()
    }
    

       func getAllUserProgress() {
           Task {
               let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
               self.userProgress = try await UserManager.shared.getAllUserProgress(userId: authDataResult.uid)
            }
       }
       
       func removeUserProgress(progressId: String) {
           Task {
               let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
               try? await UserManager.shared.removeUserProgress(userId: authDataResult.uid, progressId: progressId)
               getAllUserProgress()
           }
       }
       
       func updateUserProgress(progressId: String, quizScore: Int) {
           Task {
               let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
               try? await UserManager.shared.updateUserProgress(userId: authDataResult.uid, progressId: progressId, quizScore: quizScore)
               getAllUserProgress()
           }
       }

    
    func checkAnswer(_ selectedAnswer: String, quiz: Quiz) {
        self.selectedAnswer = selectedAnswer
        if selectedAnswer == quiz.questions?[currentQuestionIndex].correctAnswer {
            isCorrectAnswer = true
            userScore += 1
            progress = CGFloat(Double(currentQuestionIndex + 1) / Double(quiz.questions?.count ?? 0) * 350)
        } else {
            isCorrectAnswer = false
        }
    }

    func nextQuestion(quiz: Quiz) {
        if currentQuestionIndex + 1 < quiz.questions?.count ?? 0 {
            currentQuestionIndex += 1
            isCorrectAnswer = false
            self.selectedAnswer = ""
            
//            if userScore == 1 {
//               addUserProgress(progress: UserProgress(dateCreated: Date.now, levelId: "", categoryId: "", subCategoryId: 0, quizId: quiz.id, quizScore: userScore))
//                // get userProgress ->                
//               // progressId = userProgress.id
//            }
//            if userScore > 1 {
//                // update progress........
//                updateUserProgress(progressId: progressId, quizScore: userScore)
//            }
            
        } else {
            // Quiz completed
//            currentQuestionIndex = 0
//            isCorrectAnswer = false
//            userScore = 0
//            self.selectedAnswer = ""
//            progress = 0.00
        }
    }
}


