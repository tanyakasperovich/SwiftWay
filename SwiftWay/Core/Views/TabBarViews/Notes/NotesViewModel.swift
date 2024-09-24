//
//  NotesViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 2.01.24.
//

import CoreData
import SwiftUI

class NoteViewModel: ObservableObject {
    
    let manager = SwiftWayManager.shared
    @Published var notes: [NoteEntity] = []
    @Published var noteURLs: [URLEntity] = []
    @Published var sections: [SectionEntity] = []
    @Published var sectionURLs: [URLEntity] = []
    
    init() {
        getNotes()
       // getURLs()
    }
    
    func getNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        
        let sort = NSSortDescriptor(keyPath: \NoteEntity.title, ascending: true)
        request.sortDescriptors = [sort]
    
       // let filter = NSPredicate(format: "professionId == %@", professionId)
     //          request.predicate = filter
        
        do {
            notes = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getSections() {
        let request = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        
        let sort = NSSortDescriptor(keyPath: \SectionEntity.title, ascending: true)
        request.sortDescriptors = [sort]
    
        //let filter = NSPredicate(format: "name == %@", "Apple")
        //request.predicate = filter
        
        do {
            sections = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getURLs() {
        let request = NSFetchRequest<URLEntity>(entityName: "URLEntity")
        
        let sort = NSSortDescriptor(keyPath: \URLEntity.title, ascending: true)
        request.sortDescriptors = [sort]

        do {
            noteURLs = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addNote(title: String, subTitle: String, professionId: String) {
        let newNote = NoteEntity(context: manager.context)
        newNote.title = title
        newNote.subTitle = subTitle
        newNote.dateCreated = Date()
        newNote.professionId = professionId
        for url in noteURLs {
            newNote.addToUrls(url)
        }
        for section in sections {
            newNote.addToSections(section)
        }
        save()
    }
    
    func addURL(title: String, url: URL) {
        let newURL = URLEntity(context: manager.context)
        newURL.title = title
        newURL.url = url
        newURL.dateCreated = Date()
        noteURLs.append(newURL)
    }
    
    func addSection(title: String, subTitle: String) {
        let newSection = SectionEntity(context: manager.context)
        newSection.title = title
        newSection.subTitle = subTitle
        newSection.dateCreated = Date()
        for sectionURL in sectionURLs {
            newSection.addToUrls(sectionURL)
        }
        sections.append(newSection)
        sectionURLs.removeAll()
    }
    
    func addURLForSection(title: String, url: URL) {
        let newURL = URLEntity(context: manager.context)
        newURL.title = title
        newURL.url = url
        newURL.dateCreated = Date()
        sectionURLs.append(newURL)
    }
    
    func updateNote(existingNote: NoteEntity, newTitle: String, newSubTitle: String) {
        let existingNote = existingNote
        existingNote.title = newTitle
        existingNote.subTitle = newSubTitle
        save()
    }
    
    func updateSection(existingSection: SectionEntity, newTitle: String, newSubTitle: String) {
        let existingSection = existingSection
        existingSection.title = newTitle
        existingSection.subTitle = newSubTitle
        save()
    }
    
    func updateURL(existingURL: URLEntity, newTitle: String, newUrl: URL) {
        let existingURL = existingURL
        existingURL.title = newTitle
        existingURL.url = newUrl
        save()
    }
    
    func deleteNote(existingNote: NoteEntity) {
        let note = existingNote
        manager.context.delete(note)
        save()
    }

    func deleteSection(existingSection: SectionEntity) {
        let section = existingSection
        manager.context.delete(section)
        save()
    }
    
    func deleteURL(existingURL: URLEntity) {
        let url = existingURL
        manager.context.delete(url)
        save()
    }

    func save() {
           manager.save()
        getNotes()
    }
    
}
