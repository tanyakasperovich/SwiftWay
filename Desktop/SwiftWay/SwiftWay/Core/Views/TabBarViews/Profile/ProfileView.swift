//
//  ProfileView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 19.10.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var viewModel: SettingsViewModel
    @Binding var showSignInView: Bool
        
    @State var titleFieldText: String = ""
    
    var body: some View {
        List {
     
            if profileViewModel.isLoading {
                ProgressView()
            } else {
                if let user = profileViewModel.user {
                    
                    Text("UserId: \(user.userId)")
                    
                    if let isAnonymous = user.isAnonymous {
                        Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                    }
                    
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                    
                    Button {
                        profileViewModel.togglePremiumStatus()
                    } label: {
                        PBView(content: Text((user.isPremium ?? false) ? "Отменить подписку" : "Buy Premium").padding(.vertical, 7).padding(.horizontal), color: .accentColor, isSet: .constant(true))
                      //  PrimaryButton(text: (user.isPremium ?? false) ? "Отменить подписку" : "Buy Premium", backgroundColor: .accentColor, textColor: .white)
                    }
                    
                    
                    Section(header: HStack{
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                        .foregroundColor(.accentColor)
                    ) {
                        // Profile Settings...
                        NavigationLink {
                            SettingsView(showSignInView: $showSignInView)
                        } label: {
                            HStack {
                                Image(systemName: "gear")
                                Text("Settings")
                                
                            }
                            .font(.headline)
                        }
                        
                        NavigationLink {
                            Text("")
                        } label: {
                            HStack {
                                Image(systemName: "paperplane")
                                Text("Send My Progress")
                            }
                            .font(.headline)
                        }
                        
                        NavigationLink {
                            FavoriteTipsView()
                        } label: {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("Favorite Tips")
                            }
                            .font(.headline)
                        }
                        
                        NavigationLink {
                            Text("")
                        } label: {
                            HStack {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                Text("Progress")
                            }
                            .font(.headline)
                        }
                        
                        NavigationLink {
                           Text("")
                        } label: {
                            HStack {
                                Image(systemName: "calendar.badge.exclamationmark")
                                Text("Tasks")
                            }
                            .font(.headline)
                        }
                    }
                }
            }
            
            Section(header: HStack{
                Image(systemName: "iphone")
                Text("App")
            }
                .foregroundColor(.accentColor)
            ) {
                // About Project...
                NavigationLink {
                    Text("About Project")
                } label: {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Info")
                    }
                    .font(.headline)
                }
                
                NavigationLink {
                    Text("")
                } label: {
                    HStack {
                        Image(systemName: "message")
                        Text("Chat")
                    }
                    .font(.headline)
                }
                
                NavigationLink {
                    Text("")
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Feedback")
                    }
                    .font(.headline)
                }
                
                NavigationLink {
                    Text("")
                } label: {
                    HStack {
                        Image(systemName: "apps.iphone")
                        Text("Other Apps")
                    }
                    .font(.headline)
                }
            }
            
        }
//        .task {
//            try? await viewModel.loadCurrentUser()
//        }
        .foregroundStyle(Color.theme.fontColorBW).opacity(0.7)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                   Text("123")
                } label: {
                    Image(systemName: "person.fill")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
            .environmentObject(ProfileViewModel())
    }
}
