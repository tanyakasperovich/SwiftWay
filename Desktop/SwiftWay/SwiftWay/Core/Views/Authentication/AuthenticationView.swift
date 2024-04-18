//
//  AuthenticationView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 19.10.23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
        var body: some View {
            VStack {
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signInAnonymous()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    HeaderText(text: ("Sign In Anonymously"), color: .white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.cornerRadius(15))
                })
              
               ZStack {
                    
                    Color("ColorGoogle")
                        .frame(height: 55)
                        .cornerRadius(15)
//                   Color.black
//                   .frame(height: 57)
//                   .cornerRadius(8)
//                   Color.white
//                       .frame(height: 55.4)
//                   .cornerRadius(7)
//                   .padding(.horizontal, 0.8)
//                 
                        
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .cornerRadius(1)
                    .padding(.horizontal)
               }
          
              
                
                // Apple.....
                Button {
                    Task {
                        do {
                            try await viewModel.signInApple()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                        .allowsHitTesting(false)
                }
                .frame(height: 55)
                .cornerRadius(15)
                
                // Apple.....
                LoginWithApple()

                Spacer()
            }
            .padding()
            .navigationTitle("Sign In")
        }
    }

#Preview {
    AuthenticationView(showSignInView: .constant(false))
}


import AuthenticationServices
import FirebaseAuth
import CryptoKit

struct LoginWithApple: View {

        @State var currentNonce = ""

        var body: some View {
                VStack {
                        SignInWithAppleButton { request in
                                let nonce = randomNonceString()
                                currentNonce = nonce
                                request.requestedScopes = [.email, .fullName]
                                request.nonce = sha256(nonce)
                        } onCompletion: { result in
                                handleAppleSignIn(with: result)
                        }
                        .signInWithAppleButtonStyle(.whiteOutline)
                        .frame(height: 55)
                        //.cornerRadius(15)
                }
        }

        func handleAppleSignIn(with result: Result<ASAuthorization, Error>) {
                switch result {
                case .success(let auth):
                        switch auth.credential {
                        case let credential as ASAuthorizationAppleIDCredential:
                
                                guard let appleIDToken = credential.identityToken else {  return }
                                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }

                                // Initialize a Firebase credential, including the user's full name.
                                let credential = OAuthProvider.appleCredential(
                                        withIDToken: idTokenString,
                                        rawNonce: currentNonce,
                                        fullName: credential.fullName
                                )
                
                                // Sign in with Firebase.
                                Auth.auth().signIn(with: credential) { result, error in
                                        if let error = error {
                                                print(error.localizedDescription)
                                                return
                                        }
                                }
                        default:
                                print("Error in retrieving auth info")
                        }
                case .failure(let error):
                        print("Sign in with Apple failed: \(error.localizedDescription)")
                }
        }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
