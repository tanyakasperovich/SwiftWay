//
//  NotesView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

//struct NotesView: View {
//    @FetchRequest(sortDescriptors: []) private var notes: FetchedResults<NoteEntity>
//    @Environment(\.managedObjectContext) var context
//    
//    var body: some View {
//        VStack {
//            List(notes) { note in
//                VStack {
//                    Image(uiImage: note.viewImage)
//                        .resizable()
//                        .scaledToFit()
//                    Text(note.title ?? "")
//                }
//            }
//            
//            Button("Add Note") {
//                let note = NoteEntity(context: context)
//                note.title = "Note 1"
//                try? context.save()
//            }
//        }
//    }
////    func getImage(imageData: Data?) -> Image {      
////        if let data = imageData, let image = UIImage(data: data) {
////            return Image(uiImage: image)
////        } else {
////            return Image(systemName: "photo.fill")
////    }
////    }
//}

struct NotesView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @State private var showAddNoteView: Bool = false
    @State private var showEditView: Bool = false
    @State private var showEditNoteView: Bool = false
    var professionId: String

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if !noteViewModel.notes.filter({$0.professionId == professionId}).isEmpty {
                    VStack(spacing: 8) {
                        ForEach(noteViewModel.notes.filter({$0.professionId == professionId})) { note in
                            NavigationLink {
                                NoteView(note: note)
                            } label: {
                                HStack(alignment: .top  ) {
                                    if showEditView {
                                        Button {
                                            noteViewModel.deleteNote(existingNote: note)
                                        } label: {
                                            ButtonView(content: Image(systemName: "trash.fill").foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: .accentColor)
                                        }
                                        Spacer()
                                    }
                                    
                                    NoteCellView(note: note)
                                    Spacer()
                                    
                                    if showEditView {
                                        Button {
                                            noteViewModel.updateNote(existingNote: note, newTitle: "newTitle", newSubTitle: "newSubTitle")
                                        } label: {
                                            ButtonView(content:  Text("Edit").bold().foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: .accentColor)
                                        }
                                    }
                                }
                                .padding()
                                .background{
                                    RoundedRectangleShape(color: .accentColor.opacity(0.2))
                                }
                                .padding(.horizontal, 5)
                                .contextMenu {
                                    Button("Remove from my notes") {
                                        noteViewModel.deleteNote(existingNote: note)
                                    }
                                    Button("Edit note 🖊️") {
                                        noteViewModel.updateNote(existingNote: note, newTitle: "newTitle", newSubTitle: "newSubTitle")
                                    }
                                }
                            }
                        }
                    }
            } else {
                    VStack(spacing: 15) {
                        Button {
                            showAddNoteView = true
                        } label: {
                            ButtonView(content: VStack{
                                HStack{
                                    Image(systemName: "plus")
                                    Text("Add New Note")
                                }
                                .bold()
                                .foregroundStyle(Color.theme.fontColorWB)
                                .padding()
                                .padding(.horizontal)
                            }, backgroundColor: .accentColor)
                        }
                        
                        Text("Not found...")
                            .foregroundStyle(Color.secondary)
                        
                        Spacer()
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddNoteView = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showEditView.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
        .navigationTitle("My Notes")
        .onAppear{
            showEditView = false
        
        }
        .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(showAddNoteView: $showAddNoteView)
        })
    }
}

//struct NotesView: View {
//    @StateObject private var viewModel = NotesViewModel()
//    @State private var showAddNoteView: Bool = false
//    @State private var showEditView: Bool = false
//    @State private var showEditNoteView: Bool = false
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            if viewModel.isLoading {
//                        ProgressView()
//            } else {
//                if !viewModel.userNotes.isEmpty {
//                    VStack(spacing: 8) {
//                        ForEach(viewModel.userNotes) { note in
//                            NavigationLink {
//                                NoteView(note: note)
//                            } label: {
//                                HStack(alignment: .top  ) {
//                                    if showEditView {
//                                        Button {
//                                            viewModel.removeUserNote(noteId: note.id)
//                                        } label: {
//                                            ButtonView(content: Image(systemName: "trash.fill").foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: .accentColor)
//                                        }
//                                        Spacer()
//                                    }
//                                    
//                                    NoteCellView(note: note)
//                                    Spacer()
//                                    
//                                    if showEditView {
//                                        Button {
//                                            viewModel.updateUserNote(noteId: note.id)
//                                        } label: {
//                                            ButtonView(content:  Text("Edit").bold().foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: .accentColor)
//                                        }
//                                    }
//                                }
//                                .padding()
//                                .background{
//                                    RoundedRectangleShape(color: .accentColor.opacity(0.2))
//                                }
//                                .padding(.horizontal, 5)
//                                .contextMenu {
//                                    Button("Remove from my notes") {
//                                        viewModel.removeUserNote(noteId: note.id)
//                                    }
//                                    Button("Edit note 🖊️") {
//                                        viewModel.updateUserNote(noteId: note.id)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    VStack(spacing: 15) {
//                        Button {
//                            showAddNoteView = true
//                        } label: {
//                            ButtonView(content: VStack{
//                                HStack{
//                                    Image(systemName: "plus")
//                                    Text("Add New Note")
//                                }
//                                .bold()
//                                .foregroundStyle(Color.theme.fontColorWB)
//                                .padding()
//                                .padding(.horizontal)
//                            }, backgroundColor: .accentColor)
//                        }
//                     
//                        Text("Not found...")
//                                .foregroundStyle(Color.secondary)
//                           
//                        Spacer()
//                    }
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    showAddNoteView = true
//                } label: {
//                    Image(systemName: "plus")
//                }
//                
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    showEditView.toggle()
//                } label: {
//                    Text("Edit")
//                }
//            }
//        }
//        .navigationTitle("My Notes")
//        .onAppear{
//            viewModel.getUserNotes()
//            showEditView = false
//        }
//        .sheet(isPresented: $showAddNoteView, content: {
//            AddNoteView(showAddNoteView: $showAddNoteView)
//        })
//    }
//}

#Preview {
    NotesView(professionId: "")
     .environment(\.managedObjectContext, SwiftWayManager().context)
     //   .environmentObject(NotesViewModel())
}

struct NoteCellView: View {
    
    let note: NoteEntity
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
 
            VStack(alignment: .leading, spacing: 4) {
                Text(note.title ?? "n/a")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let description = note.subTitle {
                    Text(description)
                }
            }
            .font(.callout)
            .foregroundColor(.secondary)
        }
    }
}

struct NoteView: View {
    var note: NoteEntity
  //  @EnvironmentObject var noteViewModel: NoteViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                Text(note.title ?? "")
                    .bold()
                
                Text(note.subTitle ?? "")
                Text(note.professionId ?? "")
               
                if let urls = note.urls?.allObjects as? [URLEntity] {
                Text("URLs:")
                        .bold()
                    ForEach(urls) { url in
                        Text("\(url.url ?? URL(fileURLWithPath: ""))")
                    }
                }
                
                if let sections = note.sections?.allObjects as? [SectionEntity] {
                Text("Sections:")
                        .bold()
                    ForEach(sections) { section in
                        Text(section.title ?? "")
                        Text(section.subTitle ?? "")
                    }
                }
            }
        }
    }
}
