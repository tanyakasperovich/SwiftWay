//
//  AddNoteView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct AddNoteView: View {
    @Binding var showAddNoteView: Bool
    
    @State var noteTitle_TextField: String = ""
    @State var noteSubTitle_TextField: String = ""
    @State var showURLFormView: Bool = false
    @State var noteURLTitle_TextField: String = ""
    @State var noteURL_TextField: String = ""
    
    @State var showSectionFormView: Bool = false
    @State var sectionTitle_TextField: String = ""
    @State var sectionSubTitle_TextField: String = ""
    @State var showSectionURLFormView: Bool = false
    @State var sectionURLTitleSection_TextField: String = ""
    @State var sectionURLSection_TextField: String = ""
    
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                Text("Add new note...")
                    .bold()
                
                VStack(spacing: 30) {
                  // Title, SubTitle, URLs...
                    VStack {
                        // Note Title...
                        TextField("Add title here...", text: $noteTitle_TextField)
                        // .textInputAutocapitalization(.words)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 55)
                            .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                            .cornerRadius(15)
                        
                        // Note SubTitle...
                        TextField("Add note here...", text: $noteSubTitle_TextField)
                            .font(.headline)
                            .padding(.leading)
                            .frame(height: 150)
                            .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                            .cornerRadius(15)
                        
                        //                    HStack {
                        ////                        Button {
                        ////                            selecledColor = .accent
                        ////                        } label: {
                        ////                            ZStack {
                        ////                                RoundedRectangleShape(color: Color.accentColor)
                        ////                                    .frame(width: 40, height: 40)
                        ////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                        ////
                        ////                                RoundedRectangleShape(color: selecledColor == .accent ? Color.white : Color.accentColor)
                        ////                                    .frame(width: 15, height: 15)
                        ////                            }
                        ////                        }
                        ////                        Button {
                        ////                            selecledColor = .swift
                        ////                        } label: {
                        ////                            ZStack {
                        ////                                RoundedRectangleShape(color: Color.theme.orangeColor)
                        ////                                    .frame(width: 40, height: 40)
                        ////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                        ////
                        ////                                RoundedRectangleShape(color: selecledColor == .swift ? Color.white : Color.theme.orangeColor)
                        ////                                    .frame(width: 15, height: 15)
                        ////                            }
                        ////                        }
                        ////                        Button {
                        ////                            selecledColor = .swiftUI
                        ////                        } label: {
                        ////                            ZStack {
                        ////                                RoundedRectangleShape(color: Color.theme.purpleColor)
                        ////                                    .frame(width: 40, height: 40)
                        ////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                        ////
                        ////                                RoundedRectangleShape(color: selecledColor == .swiftUI ? Color.white : Color.theme.purpleColor)
                        ////                                    .frame(width: 15, height: 15)
                        ////                            }
                        ////                        }
                        ////                        Button {
                        ////                            selecledColor = .uIKit
                        ////                        } label: {
                        ////                            ZStack {
                        ////                                RoundedRectangleShape(color: Color.theme.blueColor)
                        ////                                    .frame(width: 40, height: 40)
                        ////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                        ////
                        ////                                RoundedRectangleShape(color: selecledColor == .uIKit ? Color.white : Color.theme.blueColor)
                        ////                                    .frame(width: 15, height: 15)
                        ////                            }
                        ////                        }
                        //
                        //                    }
                        
                        //                    Picker(
                        //                        selection: $selectedProfession,
                        //                        label:
                        //                            HStack {
                        //                                Text("Filter:")
                        //                                Text(selectedProfession.title ?? "")
                        //                            }
                        //                            .font(.headline)
                        //                            .foregroundColor(.white)
                        //                            .padding()
                        //                            .padding(.horizontal)
                        //                            .background(Color.blue)
                        //                            .cornerRadius(10)
                        //                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
                        //                        ,
                        //                        content: {
                        //                            ForEach(roadMapViewModel.professions, id: \.self) { profession in
                        //                                HStack {
                        //                                    Text(profession.title ?? "")
                        //                                }
                        //                                .tag(profession)
                        //                            }
                        //                        })
                        //                    .pickerStyle(MenuPickerStyle())
                        
                        // NOTE URLs...
                        VStack(alignment: .leading, spacing: 8) {
                            // NoteURL List...
                            if !noteViewModel.noteURLs.isEmpty {
                                    HStack(alignment: .top) {
                                        Text("URLs:")
                                            .bold()
                                        Spacer()
                                    }
                                    
                                    ForEach(noteViewModel.noteURLs) { url in
                                        VStack(alignment: .leading) {
                                            Text(url.title ?? "")
                                                .fontWeight(.semibold)
                                            Text("\(url.url ?? URL(fileURLWithPath: ""))")
                                        }
                                        //.padding(.vertical)
                                    }
                            }
                            
                            // Button +Add New URL...
                            HStack(alignment: .top) {
                                if showURLFormView {
                                    Spacer()
                                }
                                Button {
                                    withAnimation {
                                        showURLFormView.toggle()
                                       if showURLFormView {
                                           noteURLTitle_TextField = ""
                                           noteURL_TextField = ""
                                        }
                                    }
                                } label: {
                                    ButtonView(content: VStack{
                                        HStack{
                                            Image(systemName: showURLFormView ? "xmark" : "plus")
                                            if !showURLFormView {
                                                Text("Add New URL")
                                            }
                                        }
                                        .bold()
                                        .foregroundStyle(Color.theme.fontColorWB)
                                        .padding()
                                        .padding(.horizontal)
                                    }, backgroundColor: showURLFormView ? Color.red : .accentColor)
                                }
                            }
                            
                            // NoteURL Form...
                            if showURLFormView {
                                VStack {
                                    TextField("Add URL Title here...", text: $noteURLTitle_TextField)
                                        .font(.headline)
                                        .padding(.leading)
                                        .frame(height: 45)
                                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                        .cornerRadius(15)
                                    TextField("Add URL here...", text: $noteURL_TextField)
                                        .font(.headline)
                                        .padding(.leading)
                                        .frame(height: 45)
                                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                        .cornerRadius(15)
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Button (action: {
                                            guard !noteURL_TextField.isEmpty else { return }
                                            noteViewModel.addURL(title: noteURLTitle_TextField, url: URL(string: noteURL_TextField) ?? URL(fileURLWithPath: ""))
                                            noteURLTitle_TextField = ""
                                            noteURL_TextField = ""
                                            showURLFormView = false
                                        }, label: {
                                            ButtonView(content: VStack{
                                                HStack{
                                                    // Image(systemName: "plus")
                                                    Text("Save URL")
                                                }
                                                .bold()
                                                .foregroundStyle(noteURL_TextField.isEmpty ? .secondary : Color.theme.fontColorWB)
                                                .padding()
                                                .padding(.horizontal)
                                            },
                                                       backgroundColor: .accentColor.opacity(noteURL_TextField.isEmpty ? 0.7 : 1))
                                        }
                                                )
                                        .disabled(noteURL_TextField.isEmpty)
                                        
                                    }
                                }
                            }
                        }
                    }
                   
                    // Sections...
                    VStack(alignment: .leading, spacing: 8) {
                        // Section Title...
                        HStack(alignment: .top) {
                            Text("Sections:")
                                .bold()
                                .foregroundStyle(Color.secondary)
                            Spacer()
                        }
                        
                        // Section List...
                        if !noteViewModel.sections.isEmpty {
                            ForEach(noteViewModel.sections) { section in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(section.title ?? "")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    Text(section.subTitle ?? "")
                                    if let urls = section.urls?.allObjects as? [URLEntity] {
                                        ForEach(urls) { sectionURL in
                                            VStack(alignment: .leading) {
                                                Text(sectionURL.title ?? "")
                                                    .fontWeight(.semibold)
                                                Text("\(sectionURL.url ?? URL(fileURLWithPath: ""))")
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background {
                                    Color.accentColor.opacity(0.2)
                                }
                                //.padding(.vertical)
                            }
                        }
                        
                        // Button +Add New Section...
                        HStack(alignment: .top) {
                            if showSectionFormView {
                                Spacer()
                            }
                            
                            if !showSectionFormView {
                                Spacer()
                            }
                            
                            Button {
                                showSectionFormView.toggle()
                                if showSectionFormView {
                                    sectionTitle_TextField = ""
                                    sectionSubTitle_TextField = ""
                                    showSectionURLFormView = false
                                    sectionURLTitleSection_TextField = ""
                                    sectionURLSection_TextField = ""
                                }
                            } label: {
                                ButtonView(content: VStack{
                                    HStack{
                                        Image(systemName: showSectionFormView ? "xmark" : "plus")
                                        if !showSectionFormView {
                                            Text("Add New Section")
                                        }
                                    }
                                    .bold()
                                    .foregroundStyle(Color.theme.fontColorWB)
                                    .padding()
                                    .padding(.horizontal)
                                }, backgroundColor: showSectionFormView ? Color.red : .accentColor)
                            }
                            if !showSectionFormView {
                                 Spacer()
                            }
                        }
                        
                        // Section Form..
                        if showSectionFormView {
                            VStack {
                                TextField("Add Section Title here...", text: $sectionTitle_TextField)
                                    .font(.headline)
                                    .padding(.leading)
                                    .frame(height: 45)
                                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                    .cornerRadius(15)
                                TextField("Add Section Subtitle here...", text: $sectionSubTitle_TextField)
                                    .font(.headline)
                                    .padding(.leading)
                                    .frame(height: 45)
                                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                    .cornerRadius(15)
                                
                                // Section URLs...
                                VStack(alignment: .leading, spacing: 8) {
                                    // SectionURL List...
                                    if !noteViewModel.sectionURLs.isEmpty {
                                            HStack(alignment: .top) {
                                                Text("URLs:")
                                                    .bold()
                                                Spacer()
                                            }
                                            
                                            ForEach(noteViewModel.sectionURLs) { url in
                                                VStack(alignment: .leading) {
                                                    Text(url.title ?? "")
                                                        .fontWeight(.semibold)
                                                    Text("\(url.url ?? URL(fileURLWithPath: ""))")
                                                }
                                            }
                                    }
                                    
                                    // Button +Add Image / +Add New URL...
                                    HStack(alignment: .top) {
                                        Button {
                                         //
                                        } label: {
                                            ButtonView(content: VStack{
                                                HStack{
                                                    Image(systemName: "plus")
                                                    Text("Add Image")
                                                }
                                                .bold()
                                                .foregroundStyle(Color.theme.fontColorWB)
                                                .padding()
                                                .padding(.horizontal)
                                            }, backgroundColor: Color.theme.fontColor)
                                        }
                                        
                                        if !showSectionURLFormView {
                                            Button {
                                                withAnimation {
                                                    showSectionURLFormView = true
                                                }
                                            } label: {
                                                ButtonView(content: VStack{
                                                    HStack{
                                                        Image(systemName: "plus")
                                                        Text("Add New URL")
                                                    }
                                                    .bold()
                                                    .foregroundStyle(Color.theme.fontColorWB)
                                                    .padding()
                                                    .padding(.horizontal)
                                                }, backgroundColor: .accentColor)
                                            }
                                        }
                                    }
                                    
                                    // Button +Add New URL...
//                                    HStack(alignment: .top) {
//                                        
//                                        if showSectionURLFormView {
//                                            Spacer()
//                                        }
//                                        Button {
//                                            withAnimation {
//                                                showSectionURLFormView.toggle()
//                                               if showSectionURLFormView {
//                                                   sectionURLTitleSection_TextField = ""
//                                                   sectionURLSection_TextField = ""
//                                                }
//                                            }
//                                        } label: {
//                                            ButtonView(content: VStack{
//                                                HStack{
//                                                    Image(systemName: showSectionURLFormView ? "xmark" : "plus")
//                                                    if !showSectionURLFormView {
//                                                        Text("Add New URL")
//                                                    }
//                                                }
//                                                .bold()
//                                                .foregroundStyle(Color.theme.fontColorWB)
//                                                .padding()
//                                                .padding(.horizontal)
//                                            }, backgroundColor: showSectionURLFormView ? Color.red : .accentColor)
//                                        }
//                                    }
                                    
                                    // NoteURL Form...
                                    if showSectionURLFormView {
                                        VStack {
                                            TextField("Add URL Title here...", text: $sectionURLTitleSection_TextField)
                                                .font(.headline)
                                                .padding(.leading)
                                                .frame(height: 45)
                                                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                                .cornerRadius(15)
                                            TextField("Add URL here...", text: $sectionURLSection_TextField)
                                                .font(.headline)
                                                .padding(.leading)
                                                .frame(height: 45)
                                                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                                .cornerRadius(15)
                                            
                                            // Button "X" / "Save SectionURL"...
                                            HStack {
                                                Button (action: {
                                                    
                                                }, label: {
                                                    ButtonView(content: VStack{
                                                        HStack{
                                                            Image(systemName: "xmark")
                                                        }
                                                        .bold()
                                                        .foregroundStyle(Color.theme.fontColorWB)
                                                        .padding()
                                                        .padding(.horizontal)
                                                    }, backgroundColor: Color.red)
                                                })
                                                        
                                               // Spacer()
                                                
                                                Button (action: {
                                                    guard !sectionURLSection_TextField.isEmpty else { return }
                                                    noteViewModel.addURLForSection(title: sectionURLTitleSection_TextField, url: URL(string: sectionURLSection_TextField) ?? URL(fileURLWithPath: ""))
                                                    sectionURLTitleSection_TextField = ""
                                                    sectionURLSection_TextField = ""
                                                    showSectionURLFormView = false
                                                }, label: {
                                                    ButtonView(content: VStack{
                                                        HStack{
                                                            // Image(systemName: "plus")
                                                            Text("Save URL")
                                                        }
                                                        .bold()
                                                        .foregroundStyle(sectionURLSection_TextField.isEmpty ? .secondary : Color.theme.fontColorWB)
                                                        .padding()
                                                        .padding(.horizontal)
                                                    },
                                                               backgroundColor: .accentColor.opacity(sectionURLSection_TextField.isEmpty ? 0.7 : 1))
                                                }
                                                        )
                                                .disabled(sectionURLSection_TextField.isEmpty)
                                                
                                            }
                                        }
                                    }
                                }
                                
                                // Button SAVE Section...
                                HStack {
                                  //  Spacer()
                                    
                                    Button(action: {
                                        guard !sectionTitle_TextField.isEmpty else { return }
                                        noteViewModel.addSection(title: sectionTitle_TextField, subTitle: sectionSubTitle_TextField)
                                        //noteViewModel.addURL(title: noteURLTitle_TextField, url: URL(string: noteURL_TextField) ?? URL(fileURLWithPath: ""))
                                        sectionTitle_TextField = ""
                                        sectionSubTitle_TextField = ""
                                        //sectionURLs = []
                                        showSectionFormView = false
                                    }, label: {
                                        ButtonView(content: VStack{
                                            HStack{
                                                // Image(systemName: "plus")
                                                Text("Save Section")
                                            }
                                            .bold()
                                            .foregroundStyle(
                                                (sectionTitle_TextField.count < 3 || sectionSubTitle_TextField.isEmpty) ? .secondary : Color.theme.fontColorWB)
                                            .padding()
                                            .padding(.horizontal)
                                        },
                                                   backgroundColor: .accentColor.opacity((sectionTitle_TextField.count < 3 || sectionSubTitle_TextField.isEmpty) ? 0.7 : 1))
                                    })
                                    .disabled(sectionTitle_TextField.count < 3)
                                }
                            }
                        }
                    }
                }
                
                // Button SAVE...
                Button(action: {
                    guard !noteTitle_TextField.isEmpty else { return }
                    
                    noteViewModel.addNote(title: noteTitle_TextField, subTitle: noteSubTitle_TextField, professionId: roadMapViewModel.selectedProfession?.id ?? "")

                    noteTitle_TextField = ""
                    noteSubTitle_TextField = ""
                    showAddNoteView = false
                }, label: {
                    ZStack {
                        RoundedRectangleShape(color: .accentColor)
                            .opacity(disableForm ? 0.7 : 1)
                            .frame(height: 55)
                            .shadow(color: Color.black, radius: 2, x: -1, y: 1)
                        
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(disableForm ? .secondary : .white)
                            .padding()
                    }
                })
                .disabled(disableForm)
            }
            .padding(.top)
            .padding(.horizontal, 8)
        }
    }
    
    var disableForm: Bool {
        noteTitle_TextField.count < 3
    }
}

//struct AddNoteView: View {
//    @State var titleFieldText: String = ""
//    @State var descriptionFieldText: String = ""
//    @Binding var showAddNoteView: Bool
//    
//   // @EnvironmentObject var viewModel: NotesViewModel
//    @EnvironmentObject var profileViewModel: ProfileViewModel
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack {
//                Text("Add new note...")
//                    .bold()
//                VStack(spacing: 20) {
//                    TextField("Add title here...", text: $titleFieldText)
//                    // .textInputAutocapitalization(.words)
//                        .font(.headline)
//                        .padding(.leading)
//                        .frame(height: 55)
//                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
//                        .cornerRadius(15)
//                        .padding(.horizontal)
//                    
//                    TextField("Add note here...", text: $descriptionFieldText)
//                        .font(.headline)
//                        .padding(.leading)
//                        .frame(height: 150)
//                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
//                        .cornerRadius(15)
//                        .padding(.horizontal)
//                    
////                    HStack {
//////                        Button {
//////                            selecledColor = .accent
//////                        } label: {
//////                            ZStack {
//////                                RoundedRectangleShape(color: Color.accentColor)
//////                                    .frame(width: 40, height: 40)
//////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
//////                                
//////                                RoundedRectangleShape(color: selecledColor == .accent ? Color.white : Color.accentColor)
//////                                    .frame(width: 15, height: 15)
//////                            }
//////                        }
//////                        Button {
//////                            selecledColor = .swift
//////                        } label: {
//////                            ZStack {
//////                                RoundedRectangleShape(color: Color.theme.orangeColor)
//////                                    .frame(width: 40, height: 40)
//////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
//////                                
//////                                RoundedRectangleShape(color: selecledColor == .swift ? Color.white : Color.theme.orangeColor)
//////                                    .frame(width: 15, height: 15)
//////                            }
//////                        }
//////                        Button {
//////                            selecledColor = .swiftUI
//////                        } label: {
//////                            ZStack {
//////                                RoundedRectangleShape(color: Color.theme.purpleColor)
//////                                    .frame(width: 40, height: 40)
//////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
//////                                
//////                                RoundedRectangleShape(color: selecledColor == .swiftUI ? Color.white : Color.theme.purpleColor)
//////                                    .frame(width: 15, height: 15)
//////                            }
//////                        }
//////                        Button {
//////                            selecledColor = .uIKit
//////                        } label: {
//////                            ZStack {
//////                                RoundedRectangleShape(color: Color.theme.blueColor)
//////                                    .frame(width: 40, height: 40)
//////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
//////                                
//////                                RoundedRectangleShape(color: selecledColor == .uIKit ? Color.white : Color.theme.blueColor)
//////                                    .frame(width: 15, height: 15)
//////                            }
//////                        }
////                        
////                    }
//                    
//                    Button(action: {
//                        guard !titleFieldText.isEmpty else { return }
//                        profileViewModel.addUserNote(note: UserNote(title: titleFieldText, description: descriptionFieldText, url: "", dateCreated: Date.now, professionId: profileViewModel.user?.selectedProfession ?? ""))
//                        titleFieldText = ""
//                        descriptionFieldText = ""
//                        showAddNoteView = false
//                    }, label: {
//                        ZStack {
//                            RoundedRectangleShape(color: .accentColor)
//                                .opacity(disableForm ? 0.7 : 1)
//                                .frame(height: 55)
//                                .shadow(color: Color.black, radius: 2, x: -1, y: 1)
//                            
//                            Text("Save")
//                                .font(.headline)
//                                .foregroundColor(disableForm ? .secondary : .white)
//                                .padding()
//                        }
//                    })
//                    .disabled(disableForm)
//                    .padding(.horizontal)
//                }
//                .padding(.top)
//            }
//            .padding(.top)
//        }
//    }
//    
//    var disableForm: Bool {
//        titleFieldText.count < 3
//    }
//}

#Preview {
    AddNoteView(showAddNoteView: .constant(false))
        .environmentObject(NoteViewModel())
        .environmentObject(RoadMapViewModel())

//        .environmentObject(ProfileViewModel())
}
