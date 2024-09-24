//
//  UserMentorProfileList.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 27.05.24.
//

import SwiftUI

struct UserMentorProfileList: View {
    @EnvironmentObject var userMentorProfileViewModel: UserMentorProfileViewModel
    @State private var showAddMentorProfile = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            HStack {
                Button {
                    showAddMentorProfile = true
                } label: {
                    ButtonView(content:
                        HeaderText(text: "+ Add Mentor Profile", color: Color.theme.fontColorWB)
                        .padding()
                               ,
                               backgroundColor: .accentColor)
                }
            }
            .padding(.vertical)
            
            UserMentorListView(mentors: userMentorProfileViewModel.userMentorProfiles)
                .navigationTitle("Mentor Profiles")
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                try? await userMentorProfileViewModel.getAllUserMentorProfiles()
            }
        }
        .sheet(isPresented: $showAddMentorProfile, content: {
            AddMentorProfileView(showAddMentorProfile: $showAddMentorProfile)
       })
    }
}

#Preview {
    UserMentorProfileList()
}

struct UserMentorListView: View {
    var mentors: [Mentor]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(mentors) { mentor in
                NavigationLink {
                    MentorViewDraft(mentor: mentor)
                } label: {
                    MentorCardView(mentor: mentor)
                }
            }
        }
    }
}

struct MentorProfileView: View {
    var mentor: Mentor

    var body: some View {
        CardView(content:
                    VStack(alignment: .leading) {
            // Phote...
            VStack(alignment: .center) {
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
                        }, backgroundColor: .accentColor)
                        
                        Text("Students")
                            .lineLimit(1)
                            .font(.caption2)
                            .foregroundStyle(Color.secondary)
                    }
                    
                    CircleImage(image: Image(mentor.image ?? ""))
                        .frame(width: 130, height: 130)
                    
                    VStack {
                        ButtonView(content: VStack {
                            Text("\(String(mentor.price ?? 0))$")
                                .bold()
                                .font(.subheadline)
                                .foregroundStyle(Color.theme.fontColor)
                                .opacity(0.75)
                                .lineLimit(1)
                                .frame(width: 55)
                        }, backgroundColor: .accentColor)
                        
                        Text("Hourtly rate")
                            .lineLimit(1)
                            .font(.caption2)
                            .foregroundStyle(Color.secondary)
                    }
                }
                .offset(y: -65)
                .padding(.bottom, -50)
            }
            
            // Title + Links...
            VStack(alignment: .center) {
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
                                   backgroundColor: .accentColor)
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
                                   backgroundColor: .accentColor)
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
            
            VStack(spacing: 15) {
                if let description = mentor.description {
                    HStack {
                        Text("About me")
                        Spacer()
                    }
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
                                    Text("\(String(skill.price))")
                                        .padding(.horizontal, 2)
                                    Image(systemName: "chevron.forward")
                                }
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundStyle(Color.theme.fontColor)
                                    .opacity(0.85)
                                    .padding(7)
                                    .padding(.horizontal, 3)
                                        ,
                                       color: .accentColor,
                                        isSet: .constant(true))
                            }
                        }
                    }
                }
            }
                .foregroundStyle(Color.theme.fontColorBW)
        }
                 , color: .accentColor)
        .padding(.bottom, 8)
        //.padding(.horizontal, 5)
    }
}

struct MentorViewDraft: View {
    var mentor: Mentor
    @EnvironmentObject var mentorViewModel: MentorViewModel
    @State private var showAddPostView: Bool = false

    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
            MentorProfileView(mentor: mentor)
                    .padding(.horizontal, 5)
          
               // Button "Public Mentor Profile"...
            if mentorViewModel.mentors.filter({$0.id == mentor.id}).isEmpty {
                HStack {
                    Button {
                        Task {
                           try? await mentorViewModel.addMentorProfile(mentor: mentor)
                            try? await mentorViewModel.getAllMentors()
                        }
                    } label: {
                        ButtonView(content:
                                    HeaderText(text: "Public Mentor Profile", color: Color.theme.fontColorWB)
                            .padding()
                                   ,
                                   backgroundColor: Color.theme.fontColor)
                    }
                }
                .padding()
            }
                // Posts...
                else {
                    VStack {
                        HStack {
                            Button {
                                showAddPostView = true
                            } label: {
                                ButtonView(content:
                                            HeaderText(text: "+ Add New Post", color: Color.theme.fontColorWB)
                                    .padding()
                                           ,
                                           backgroundColor: .accentColor)
                            }
                        }
                        .padding()
                        
                        // Posts...
                        UserProfileView(userId: mentor.userId ?? "")
                    }
                    
                }
        }
        .padding(.top, 40)
        }
        .sheet(isPresented: $showAddPostView, content: {
           //AddPostView(showAddPostView: $showAddPostView)
       })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink {
                        //
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

struct AddMentorProfileView: View {
    @Binding var showAddMentorProfile: Bool
    @EnvironmentObject var userMentorProfileViewModel: UserMentorProfileViewModel
    @EnvironmentObject var mentorViewModel: MentorViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State var nameFieldText: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Button X...
                HStack {
                    Spacer()
                    Button {
                        showAddMentorProfile = false
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .foregroundStyle(Color.accentColor)
                    }
                }
                .padding()
                
                
                VStack {
                    Text("Add new Mentor Profile...")
                        .bold()
                    VStack(spacing: 20) {
                        TextField("Add Name here...", text: $nameFieldText)
                            .textInputAutocapitalization(.words)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 55)
                            .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                            .cornerRadius(15)
                            .padding(.horizontal)

                    }
                    .padding(.top)
                }
                .padding(.top)
                
                Spacer()
                
                // Button "Save And Public", "Save"...
                HStack(spacing: 8) {
                    if let user = profileViewModel.user {
                        
                        let mentor = Mentor(userId: user.userId, name: nameFieldText, image: "1", professionId: user.selectedProfession, price: 0.0, rating: 0.0, reviews: [], linkedInLink: "", instagramLink: "", youTubeLink: "", link: "", description: "", students: [], skills: [])
                        
                        Button {
                            Task {
                                try? await userMentorProfileViewModel.addMentorProfile(mentor: mentor)
                                try? await mentorViewModel.addMentorProfile(mentor: mentor)
                                
                                showAddMentorProfile = false
                            }
                        } label: {
                            ButtonView(content:
                                        HeaderText(text: "Save And Public", color: Color.theme.fontColorWB)
                                .padding()
                                       ,
                                       backgroundColor: Color.theme.fontColor.opacity(disableForm ? 0.4 : 1))
                        }
                        
                        Button {
                            Task {
                                try? await userMentorProfileViewModel.addMentorProfile(mentor: mentor)
                                showAddMentorProfile = false
                            }
                        } label: {
                            ButtonView(content:
                                        HeaderText(text: "Save", color: Color.theme.fontColorWB)
                                .padding()
                                       ,
                                       backgroundColor: .accentColor.opacity(disableForm ? 0.4 : 1))
                        }
                    }
                }
                .disabled(disableForm)
                .padding(10)
            }
        }
        
        var disableForm: Bool {
            nameFieldText.count < 2
        }
        
    }
}
