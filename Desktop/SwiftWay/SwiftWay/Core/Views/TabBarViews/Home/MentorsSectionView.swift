//
//  MentorsSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 24.03.24.
//

import SwiftUI

struct MentorsSectionView: View {
    @StateObject private var mentorViewModel = MentorViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("MENTORS")
                .bold()
                .padding(.horizontal)
                .padding(.top, 5)
                .foregroundStyle(Color.theme.fontColorBW)
                .opacity(0.7)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 8)
                    ForEach(Professions.allCases, id: \.self) { profession in
                        NavigationLink {
                            MentorListView(mentorViewModel: mentorViewModel, speciality: profession)
                        } label: {
                            ProfessionCardView(profession: profession)
                        }
                    }
                    Spacer(minLength: 8)
                }
            }
            .frame(height: 220)
            
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
                            MentorView(mentor: mentor)
                        } label: {
                            
                            Circle()
                                .frame(width: 70)
                                .shadow(color: Color.black, radius: 1, x: 1, y: -1)
                                .padding(.top, 2)
                        }
                    }
                    Spacer(minLength: 8)
                }
            }
   
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    NavigationStack {
          MentorsSectionView()
//        MentorView(mentor:  MentorModel(name: "Name NameName", image: "Marni2", speciality: [.iosDeveloper, .productDesigner], price: 15.0, rating: 0.0, reviews: [ReviewModel(nameAuthor: "Name Surname", review: "Review review review review review review. review, review review review review review, reviewreview.", date: Date.now), ReviewModel(nameAuthor: "Name Surname", review: "Review review review review review review. review, review review review review review, reviewreview.", date: Date.now)], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "I'm a senior IOS developer at Name with 7+ years of experience in the design industry. I'm sharing educational content on my social media accounts, where I incteract with more than 200k followers.", students: [], skills: [SkillModel(title: "Skill title 1", description: "Skill description"), SkillModel(title: "Skill title 2", description: "Skill description"), SkillModel(title: "Skill title 3", description: "Skill description")]))
    }
}

struct ProfessionCardView: View {
    var profession: Professions
    
    var body: some View {
        CardView(content:
                    VStack(alignment: .leading) {
            HStack {
                Text(profession.rawValue)
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(.bottom)
            .foregroundStyle(Color.theme.fontColorBW)
            
            HStack {
                Text(profession.description)
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
                 , color: Color.accentColor)
        .padding(.top, 5)
        .frame(width: 300)
    }
}

struct MentorListView: View {
    var mentorViewModel: MentorViewModel
    var speciality: Professions
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            let filterMentorsForSpeciality = mentorViewModel.mentors.filter({item in
                let filterMentors = item.speciality.filter({$0 == speciality.rawValue})
                return !filterMentors.isEmpty})
            
            ForEach(filterMentorsForSpeciality) { mentor in
                NavigationLink {
                    MentorView(mentor: mentor)
                } label: {
                    MentorCardView(mentor: mentor)
                }
            }
        }
        .navigationTitle(speciality.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MentorCardView: View {
    var mentor: Mentor
    
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
                 , color: Color.accentColor)
        .padding(5)
    }
}

struct MentorView: View {
    var mentor: Mentor
    @State private var selectedView = 0
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
       // formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CardView(content:
                        VStack {
                // Phote...
                HStack(alignment: .bottom) {
                    VStack {
                        ButtonView(content: VStack {                            Text("\(mentor.students.count)")
                                .bold()
                                .font(.subheadline)
                                .foregroundStyle(Color.theme.fontColor)
                                .opacity(0.75)
                                .lineLimit(1)
                                .frame(width: 55)
                        }, backgroundColor: Color.accentColor)
                        
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
                        }, backgroundColor: Color.accentColor)
                        
                        Text("Hourtly rate")
                            .lineLimit(1)
                            .font(.caption2)
                            .foregroundStyle(Color.secondary)
                    }
                }
                .offset(y: -65)
                .padding(.bottom, -50)
                
                // Title
                VStack {
                    Text(mentor.name ?? "")
                        .foregroundStyle(Color.theme.fontColor)
                        .font(.title3)
                        .bold()
                    
                    HStack {
                        ForEach(mentor.speciality, id: \.self) {speciality in
                            HStack {
                                Text(speciality)
                                
                                if mentor.speciality.last != speciality {
                                    Text("/")
                                }
                            }
                            .foregroundStyle(Color.secondary)
                            .font(.subheadline)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Button {
                            //
                        } label: {
                            ButtonView(content:
                                        HStack {
                                Spacer()
                                Text("BOOK")
                                    .foregroundStyle(Color.theme.fontColorWB)
                                Spacer()
                            }
                                .padding(.vertical, 9)
                                       ,
                                       backgroundColor: Color.accentColor)
                        }
                    }
                    .padding(.bottom)
                    
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
                
                // ....
                VStack {
                    Picker("", selection: $selectedView) {
                        Text("About me")
                            .tag(0)
                        
                        Text("Reviews")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom, 8)
                    
                    if selectedView == 0 {
                        VStack {
                            Text(mentor.description ?? "")
                                .font(.subheadline)
                                .padding(.bottom, 15)
                            
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
                                        .foregroundStyle(Color.theme.fontColorBW)
                                        .opacity(0.75)
                                        .padding(7)
                                       // .padding(.horizontal)
                                       // .padding(.vertical, 7)
                                               ,
                                               color: .accentColor,
                                               isSet: .constant(true))
//                                    
//                                        .background(
//                                            
//
//                                            PrimaryButton(text: "", backgroundColor: Color.accentColor, textColor: Color.clear)
//                                        )
                                    }
                                }
                            }
                            //.padding(.horizontal, 10)
                        }
                        .foregroundStyle(Color.theme.fontColorBW)
                    } else {
                        
                        if !mentor.reviews.isEmpty {
                            VStack {
                                    ForEach(mentor.reviews) {review in
                                        VStack {
                                            HStack {
                                                Text(review.nameAuthor)
                                                    .bold()
                                                Spacer()
                                                
                                                Text(dateFormatter.string(from: review.date))
                                                    .font(.subheadline)
                                                    .bold()
                                            }
                                            .padding(.bottom, 5)
                                            
                                            Text(review.review)
                                                .font(.subheadline)
                                        }
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(Color.secondary)
                                                .opacity(0.15)
                                        }
                                    }
                            }
                        } else {
                            VStack {
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
                     , color: Color.accentColor)
            .padding(.horizontal, 5)
            .padding(.top, 40)
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
        
    }
}
