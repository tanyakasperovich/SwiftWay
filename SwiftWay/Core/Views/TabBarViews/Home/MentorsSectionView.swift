//
//  MentorsSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 24.03.24.
//

import SwiftUI

struct MentorsSectionView: View {
    @EnvironmentObject var mentorViewModel: MentorViewModel
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Image(systemName: "person.3.fill")
                    .foregroundStyle(Color.theme.fontColor.opacity(0.7))
                    .bold()
                .padding(.trailing, 5)
                
                HeaderText(text: ("Mentors").uppercased(), color: .theme.fontColorBW.opacity(0.7))
        }
            .padding(.horizontal)
            .padding(.bottom, 5)
        
            // Hot Pick For You....
            VStack(alignment: .leading) {
                Text("💥 Hot Pick For You")
                    .font(.body)
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(Color.theme.fontColorBW)
                   // .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                       // Spacer(minLength: 10)
                        
                        ForEach(mentorViewModel.mentors.filter({$0.professionId == roadMapViewModel.selectedProfession?.id})) { mentor in
                            NavigationLink {
                                MentorView(mentor: mentor)
                            } label: {
                                ProfileImage(image: Image(mentor.image ?? ""))
                                    .frame(width: 70, height: 72)
                            }
                        }
                       // Spacer(minLength: 8)
                    }
                    .padding(.horizontal, 10)
                }
            }
            
            // Sector Professions...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 8)
                   // ForEach(Professions.allCases.filter({$0.sector == selectedProfession.sector}), id: \.self) { profession in
                    ForEach(roadMapViewModel.professions, id: \.self) { profession in
                        let filterMentors = mentorViewModel.mentors.filter({$0.professionId == profession.id})
                        NavigationLink {
                            MentorListView(mentors: filterMentors)
                                .navigationTitle(profession.title ?? "")
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                           ProfessionCardView(profession: profession)
                        }
                    }
                    Spacer(minLength: 8)
                }
            }
            .frame(height: 220)
            
        }
        .padding(.bottom, 10)
        .onAppear{
            Task {
               try? await mentorViewModel.getAllMentors()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MentorsSectionView()
    }
}

struct ProfessionCardView: View {
    var profession: Profession
    
    var body: some View {
        CardView(content:
                    VStack(alignment: .leading) {
            HStack {
                Text(profession.title ?? "")
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(.bottom)
            .foregroundStyle(Color.theme.fontColorBW)
            
            HStack {
                Text(profession.title ?? "")
                    .lineLimit(2)
            }
            .font(.caption)
            .foregroundStyle(Color.secondary)
            .padding(.bottom)
            
            Spacer()
            
            HStack(alignment: .center) {
                //Text("\(category.mentors.count)")
                Text("11")
                
                    .bold()
                Text("mentors")
                    .bold()
                Spacer()
                
                Image(systemName: "arrow.right")
            }
            .font(.subheadline)
            .foregroundStyle(Color.theme.fontColorBW)
        }
            .padding(8)
                 , color: .accentColor)
        .padding(.top, 5)
        .frame(width: 300)
    }
}

struct MentorListView: View {
    var mentors: [Mentor]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(mentors) { mentor in
                NavigationLink {
                    MentorView(mentor: mentor)
                } label: {
                    MentorCardView(mentor: mentor)
                }
            }
        }
    }
}

struct MentorCardView: View {
    var mentor: Mentor
    
    var body: some View {
        CardView(content:
                    VStack(alignment: .leading) {
            HStack {
                VStack {
                    ProfileImage(image: Image(mentor.image ?? ""))
                        .frame(width: 90, height: 92)
                }
                
                VStack(alignment: .leading) {
                    Text(mentor.name ?? "")
                        .bold()
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.bottom, 5)
                        .foregroundStyle(Color.theme.fontColorBW)
                    
                    Text(mentor.name ?? "")
                        .lineLimit(2)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            
            Spacer()
            
            Divider()
            
            HStack(alignment: .center) {
                Text("\(mentor.students.count)")
                    .bold()
                Text("students")
                    .bold()
                Spacer()
                
                Text("$\(mentor.price ?? 0, specifier: "%.1f")/h")
                    .bold()
                    .foregroundStyle(Color.theme.fontColor)
                Image(systemName: "arrow.right")
            }
            .font(.subheadline)
            .foregroundStyle(Color.theme.fontColorBW)
            .padding(.top, 5)
        }
            .padding(8)
                 , color: .accentColor)
        .padding(5)
    }
}

struct MentorView: View {
    var mentor: Mentor
    @State private var selectedView = 0
    @EnvironmentObject var postViewModel: PostViewModel

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
       // formatter.timeStyle = .short
        return formatter
    }
    @State private var showAddMentorReviewView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
             
                MentorProfileView(mentor: mentor)
                
                // Picker....
                VStack {
                    Picker("", selection: $selectedView) {
                        Text("Content")
                            .tag(0)
                        
                        Text("Reviews")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
              
                    if selectedView == 0 {
                        if !postViewModel.posts.filter({$0.userId == mentor.userId ?? ""}).isEmpty {
                            CurrentAuthorPostList(userId: mentor.userId ?? "", color: Color.accentColor)
                        } else {
                            Text("No Item")
                                .foregroundStyle(Color.secondary)
                                .padding()
                        }
                    }
                    if selectedView == 1 {
                        if !mentor.reviews.isEmpty {
                            VStack {
                                ForEach(mentor.reviews) {review in
                                    NavigationLink {
                                        ReviewView(review: review)
                                    } label: {
                                        PostCardView(content:  VStack(alignment: .leading) {
                                            HStack {
                                                SmallText(text: review.userId, color: Color.theme.fontColor)
                                                
                                                Spacer()
                                                
                                                SmallText(text: dateFormatter.string(from: review.date), color: Color.secondary)
                                            }
                                            .padding(.bottom, 5)
                                            
                                            // Review Text...
                                            SubHeaderText(text: review.review, color: Color.theme.fontColorBW)
                                                .lineLimit(4)
                                                .padding(.vertical, 10)
                                                .multilineTextAlignment(.leading)
                                        }
                                           )
                                    }
                                }
                            }
                        } else {
                            VStack {
                                HStack {
                                    Button {
                                        showAddMentorReviewView = true
                                    } label: {
                                        ButtonView(content:
                                            HeaderText(text: "+ Add Review", color: Color.theme.fontColorWB)
                                            .padding()
                                                   ,
                                                   backgroundColor: .accentColor)
                                    }
                                }
                                .padding(.vertical)
                                
                                Text("No Item")
                                    .padding()
                                    .foregroundStyle(Color.secondary)
                                Image("Marni2")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
               // .padding(.horizontal, 5)
            }
            .padding(.horizontal, 5)
            .padding(.top, 40)
        }
        .onAppear{
            Task {
                try? await postViewModel.getPosts()
            }
        }
        .navigationTitle("Mentor Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart")
                    }
                    
                    
                }
            }
        }
        .sheet(isPresented: $showAddMentorReviewView, content: {
            AddMentorReviewView(showAddMentorReviewView: $showAddMentorReviewView)
       })
    }
}

struct AddMentorReviewView: View {
    @Binding var showAddMentorReviewView: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showAddMentorReviewView = false
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundStyle(Color.accentColor)
                    }
                }
                .padding()
            }
        }
    }
}

struct ReviewView: View {
    var review: ReviewModel
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
       // formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    SmallText(text: review.userId, color: Color.theme.fontColor)
                    Spacer()
                    
                    SmallText(text: dateFormatter.string(from: review.date), color: Color.secondary)
                }
                    .padding(.horizontal)
                SubHeaderText(text: review.review, color: Color.theme.fontColorBW)
                    .padding(.horizontal, 8)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
