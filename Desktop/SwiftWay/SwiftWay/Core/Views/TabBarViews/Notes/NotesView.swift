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
   
    var body: some View {
        List {
            if viewModel.isLoading {
                        ProgressView()
            } else {
                if !viewModel.userNotes.isEmpty {
                    ForEach(viewModel.userNotes) { note in
                        
                        HStack {
                            NoteCellView(note: note)
                            if showEditView {
                                Spacer()
                                Button("Delete") {
                                    viewModel.removeUserNote(noteId: note.id)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                            .contextMenu {
                                Button("Remove from my notes") {
                                    viewModel.removeUserNote(noteId: note.id)
                                }
                            }
                    }
                } else {
                    Text("Not found...")
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
            AddNoteView(color: Color.accentColor, showAddNoteView: $showAddNoteView)
        })
    }
}

#Preview {
    NotesView()
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
                
                Text((note.description ?? "n/a"))
                    
            }
            .font(.callout)
            .foregroundColor(.secondary)
            
            
            
        }
    }
}

