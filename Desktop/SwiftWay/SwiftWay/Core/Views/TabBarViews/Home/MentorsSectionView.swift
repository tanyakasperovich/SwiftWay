//
//  MentorsSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 24.03.24.
//

import SwiftUI

struct MentorsSectionView: View {
    @StateObject private var mentorViewModel = MentorViewModel()
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    var selectedProfessionId: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("MENTORS")
                .bold()
                .padding(.horizontal)
                .padding(.top, 5)
                .foregroundStyle(Color.theme.fontColorBW)
                .opacity(0.7)
            
            // Hot Pick For You....
            VStack(alignment: .leading) {
                Text("💥 Hot Pick For You")
                    .font(.body)
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(Color.theme.fontColorBW)
                    .padding(.vertical, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer(minLength: 15)
                        
                        ForEach(mentorViewModel.mentors) { mentor in
                            NavigationLink {
                                MentorView(mentor: mentor, color: Color(roadMapViewModel.selectedProfession?.color ?? "Lime"))
                            } label: {
                                Circle()
                                    .foregroundStyle(Color(roadMapViewModel.selectedProfession?.color ?? "Lime"))
                                    .frame(width: 70)
                                    .shadow(color: Color.black, radius: 1, x: 1, y: -1)
                                    .padding(.top, 2)
                            }
                        }
                        Spacer(minLength: 8)
                    }
                }
            }
            
            // Sector Professions...
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 8)
                   // ForEach(Professions.allCases.filter({$0.sector == selectedProfession.sector}), id: \.self) { profession in
                    ForEach(roadMapViewModel.professions, id: \.self) { profession in
                        NavigationLink {
                            MentorListView(mentorViewModel: mentorViewModel, profession: profession)
                                           
                        } label: {
                           ProfessionCardView(profession: profession, color: roadMapViewModel.selectedProfession?.color ?? "Lime")
                        }
                    }
                    Spacer(minLength: 8)
                }
            }
            .frame(height: 220)
            
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    NavigationStack {
        MentorsSectionView(selectedProfessionId: "")
//        MentorView(mentor:  MentorModel(name: "Name NameName", image: "Marni2", speciality: [.iosDeveloper, .productDesigner], price: 15.0, rating: 0.0, reviews: [ReviewModel(nameAuthor: "Name Surname", review: "Review review review review review review. review, review review review review review, reviewreview.", date: Date.now), ReviewModel(nameAuthor: "Name Surname", review: "Review review review review review review. review, review review review review review, reviewreview.", date: Date.now)], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "I'm a senior IOS developer at Name with 7+ years of experience in the design industry. I'm sharing educational content on my social media accounts, where I incteract with more than 200k followers.", students: [], skills: [SkillModel(title: "Skill title 1", description: "Skill description"), SkillModel(title: "Skill title 2", description: "Skill description"), SkillModel(title: "Skill title 3", description: "Skill description")]))
    }
}

struct ProfessionCardView: View {
    var profession: Profession
    var color: String
    
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
                 , color: Color(color))
        .padding(.top, 5)
        .frame(width: 300)
    }
}

struct MentorListView: View {
    var mentorViewModel: MentorViewModel
    var profession: Profession
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            let filterMentorsForSpeciality = mentorViewModel.mentors.filter({item in
                let filterMentors = item.professionId.filter({$0 == profession.id})
                return !filterMentors.isEmpty})
            
            ForEach(filterMentorsForSpeciality) { mentor in
                NavigationLink {
                    MentorView(mentor: mentor, color: Color(profession.color ?? ""))
                } label: {
                    MentorCardView(mentor: mentor, color: Color(profession.color ?? ""))
                }
            }
        }
        .navigationTitle(profession.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MentorCardView: View {
    var mentor: Mentor
    var color: Color
    
    var body: some View {
        CardView(content:
                    VStack(alignment: .leading) {
            HStack {
                VStack {
                    CircleImage(image: Image(mentor.name ?? ""))
                        .frame(width: 50, height: 50)
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
                 , color: color)
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
    var color: Color
    @State private var showAddMentorReviewView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                CardView(content:
                            VStack {
                    // Phote...
                    HStack(alignment: .bottom) {
                        VStack {
                            ButtonView(content: VStack {
                                Text("\(mentor.students.count)")
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundStyle(Color.theme.fontColor)
                                    .opacity(0.75)
                                    .lineLimit(1)
                                    .frame(width: 55)
                            }, backgroundColor: color)
                            
                            Text("Students")
                                .lineLimit(1)
                                .font(.caption2)
                                .foregroundStyle(Color.secondary)
                        }
                        
                        CircleImage(image: Image(mentor.image ?? ""))
                            .frame(width: 130)
                        
                        VStack {
                            ButtonView(content: VStack {
                                Text("\(String(mentor.price ?? 0))$")
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundStyle(Color.theme.fontColor)
                                    .opacity(0.75)
                                    .lineLimit(1)
                                    .frame(width: 55)
                            }, backgroundColor: color)
                            
                            Text("Hourtly rate")
                                .lineLimit(1)
                                .font(.caption2)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    .offset(y: -65)
                    .padding(.bottom, -50)
                    
                    // Title + Links...
                    VStack {
                        // Title...
                        Text(mentor.name ?? "")
                            .foregroundStyle(Color.theme.fontColor)
                            .font(.title3)
                            .bold()
                        
                        // Speciality...
                        //                    HStack {
                        //                        ForEach(mentor.professionsID, id: \.self) {professionId in
                        //                            HStack {
                        //                                Text(professionId ?? "")
                        //
                        //                                if mentor.professionsID.last != profession {
                        //                                    Text("/")
                        //                                }
                        //                            }
                        //                            .foregroundStyle(Color.secondary)
                        //                            .font(.subheadline)
                        //                        }
                        //                    }
                        //                    .padding(.bottom)
                        
                        // BOOK + Message...
                        HStack {
                            Button {
                                //
                            } label: {
                                ButtonView(content:
                                            HStack {
                                    Spacer()
                                    Text("BOOK")
                                        .foregroundStyle(Color.theme.fontColorWB)
                                        .bold()
                                    Spacer()
                                }
                                    .padding(.vertical, 9)
                                           ,
                                           backgroundColor: color)
                            }
                            
                            NavigationLink {
                                Text("Message")
                            } label: {
                                ButtonView(content:
                                            HStack {
                                    Spacer()
                                    Text("Message")
                                        .foregroundStyle(Color.theme.fontColorWB)
                                        .bold()
                                    Spacer()
                                }
                                    .padding(.vertical, 9)
                                           ,
                                           backgroundColor: color)
                            }
                        }
                        .padding(.bottom)
                        
                        // Social Links...
                        HStack {
                            if let linkedInLink = mentor.linkedInLink {
                                ButtonView(content:
                                            VStack {
                                    Text("in")
                                        .bold()
                                        .foregroundStyle(Color.theme.fontColorWB)
                                        .frame(width: 32, height: 32)
                                },
                                           backgroundColor: Color.blue)
                            }
                            
                            if let instagramLink = mentor.instagramLink {
                                ButtonView(content:
                                            VStack {
                                    Text("🟪")
                                        .bold()
                                        .frame(width: 32, height: 32)
                                },
                                           backgroundColor: Color.theme.darkPinkColor)
                            }
                            if let youTubeLink = mentor.youTubeLink {
                                ButtonView(content:
                                            VStack {
                                    Text("▶️")
                                        .bold()
                                        .frame(width: 32, height: 32)
                                },
                                           backgroundColor: Color.theme.redColor)
                            }
                            if let link = mentor.link {
                                ButtonView(content:
                                            VStack {
                                    Text("🔗")
                                        .bold()
                                    .frame(width: 32, height: 32)                            },
                                           backgroundColor: Color.blue)
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    }
                    
                    Text("About me")
                        VStack(spacing: 15) {
                            if let description = mentor.description {
                                Text(description)
                                    .font(.subheadline)
                            }
                            
                            VStack {
                                HStack {
                                    Text("I can help with ✌️")
                                        .font(.headline)
                                    Spacer()
                                }
                                .opacity(0.9)
                                .padding(.bottom, 5)
                                .padding(.horizontal, 5)
                                
                                VStack(alignment: .leading) {
                                    ForEach(mentor.skills) { skill in
                                        NavigationLink {
                                            ScrollView(.vertical, showsIndicators: false) {
                                                Text(skill.description)
                                                    .padding()
                                            }
                                            .navigationTitle(skill.title)
                                            
                                        } label: {
                                            PBView(content:
                                                    HStack {
                                                Text(skill.title)
                                                Spacer()
                                                Image(systemName: "chevron.forward")
                                            }
                                                .bold()
                                                .font(.subheadline)
                                                .foregroundStyle(Color.theme.fontColor)
                                                .opacity(0.85)
                                                .padding(7)
                                                .padding(.horizontal, 5)
                                                   ,
                                                   color: color,
                                                   isSet: .constant(true))
                                        }
                                    }
                                }
                                //.padding(.horizontal, 10)
                            }
                        }
                        .foregroundStyle(Color.theme.fontColorBW)
                }
                         , color: color)
                .padding(.bottom, 8)
                
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
                                                   backgroundColor: color)
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
            }
            .padding(.horizontal, 8)
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
            AddMentorReviewView(color: color, showAddMentorReviewView: $showAddMentorReviewView)
       })
    }
}

struct AddMentorReviewView: View {
//    var mentor: Mentor
    var color: Color
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
                            .foregroundStyle(color)
                    }
                }
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
