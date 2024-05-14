//
//  NotesView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showAddNoteView: Bool = false
    @State private var showEditView: Bool = false
    @State private var showEditNoteView: Bool = false
    var color: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if viewModel.isLoading {
                        ProgressView()
            } else {
                if !viewModel.userNotes.isEmpty {
                    VStack(spacing: 8) {
                        ForEach(viewModel.userNotes) { note in
                            NavigationLink {
                                NoteView(note: note, color: color)
                            } label: {
                                HStack(alignment: .top  ) {
                                    if showEditView {
                                        Button {
                                            viewModel.removeUserNote(noteId: note.id)
                                        } label: {
                                            ButtonView(content: Image(systemName: "trash.fill").foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: Color(color))
                                        }
                                        Spacer()
                                    }
                                    
                                    NoteCellView(note: note)
                                    Spacer()
                                    
                                    if showEditView {
                                        Button {
                                            viewModel.updateUserNote(noteId: note.id)
                                        } label: {
                                            ButtonView(content:  Text("Edit").bold().foregroundStyle(Color.theme.fontColorWB).padding(.horizontal), backgroundColor: Color(color))
                                        }
                                    }
                                }
                                .padding()
                                .background{
                                    RoundedRectangleShape(color: Color(color).opacity(0.2))
                                }
                                .padding(.horizontal, 5)
                                .contextMenu {
                                    Button("Remove from my notes") {
                                        viewModel.removeUserNote(noteId: note.id)
                                    }
                                    Button("Edit note 🖊️") {
                                        viewModel.updateUserNote(noteId: note.id)
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
                            }, backgroundColor: Color(color))
                        }
                     
                        Text("Not found...")
                                .foregroundStyle(Color.secondary)
                           
                        Spacer()
                    }
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
            viewModel.getUserNotes()
            showEditView = false
        }
        .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(color: Color(color), showAddNoteView: $showAddNoteView)
        })
    }
}

#Preview {
    NotesView(color: "")
     //   .environmentObject(NotesViewModel())
}

struct NoteCellView: View {
    
    let note: UserNote
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
 
            VStack(alignment: .leading, spacing: 4) {
                Text((note.title ?? "n/a"))
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let description = note.description {
                    Text(description)
                }
            }
            .font(.callout)
            .foregroundColor(.secondary)
        }
    }
}

struct NoteView: View {
    var note: UserNote
    var color: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                Text(note.title ?? "")
                    .bold()
                
                Text(note.description ?? "")
                
            }
        }
    }
}
