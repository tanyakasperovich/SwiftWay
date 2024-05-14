//
//  UserProfileView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 10.05.24.
//

import SwiftUI

struct UserProfileView: View {
    var userId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
              //  if !postViewModel.posts.filter({$0.userId == userId}).isEmpty {
                    Text("Posts:")
                        .foregroundStyle(Color.secondary)
                        .padding(.horizontal)
              //  }
                
                CurrentAuthorPostList(userId: userId, color: Color.accentColor)
            }
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    UserProfileView(userId: "")
}
