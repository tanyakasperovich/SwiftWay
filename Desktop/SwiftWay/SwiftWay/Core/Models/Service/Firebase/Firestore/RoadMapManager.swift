//
//  DataManager.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class RoadMapManager {

    static let shared = RoadMapManager()
    private init() { }

    // MARK: - RoadMap...
    private let roadMapCollection: CollectionReference = Firestore.firestore().collection("roadMap")

    private func sectorDocument(sectorId: String) -> DocumentReference {
        roadMapCollection.document(sectorId)
    }

    // загрузка Sectors.........................................................
    func uploadSectors(sector: Sector) async throws {
        try sectorDocument(sectorId: sector.id).setData(from: sector, merge: false)
    }
    //.........................................................................

    func getSector(sectorId: String) async throws -> Sector {
        try await sectorDocument(sectorId: sectorId).getDocument(as: Sector.self)
    }

    func getSectors() async throws -> [Sector] {
        try await roadMapCollection.getDocuments(as: Sector.self)
    }
    
//        func getRoadMapLevels() async throws -> [Level] {
//            try await roadMapCollection.getDocuments(as: Level.self)
//        }
    
    // MARK: - Professions....
    private func professionCollection(sectorId: String) -> CollectionReference {
        sectorDocument(sectorId: sectorId).collection("professions")
    }
    
    private func professionDocument(sectorId: String, professionId: String) -> DocumentReference {
        professionCollection(sectorId: sectorId).document(professionId)
    }
    
    // загрузка Professions.........................................................
    func uploadProfessions(sector: Sector, profession: Profession) async throws {
        try professionDocument(sectorId: sector.id, professionId: profession.id).setData(from: profession, merge: false)
    }
    //.........................................................................

    func getProfessions(sectorId: String) async throws -> [Profession] {
        try await professionCollection(sectorId: sectorId).getDocuments(as: Profession.self)
    }
    
    // MARK: - Levels....
    private func levelCollection(sectorId: String, professionId: String) -> CollectionReference {
        professionDocument(sectorId: sectorId, professionId: professionId).collection("levels")
    }
    
    private func levelDocument(sectorId: String, professionId: String, levelId: String) -> DocumentReference {
        levelCollection(sectorId: sectorId, professionId: professionId).document(levelId)
    }
    
    // загрузка Levels.........................................................
    func uploadLevels(sector: Sector, profession: Profession, level: Level) async throws {
        try levelDocument(sectorId: sector.id, professionId: profession.id, levelId: level.id).setData(from: level, merge: false)
    }
    //.........................................................................

    func getLevels(sectorId: String, professionId: String) async throws -> [Level] {
        try await levelCollection(sectorId: sectorId, professionId: professionId).getDocuments(as: Level.self)
    }
    

}


//final class RoadMapManager {
//
//    static let shared = RoadMapManager()
//    private init() { }
//    
//    // MARK: - RoadMap...
//    private let roadMapLevelsCollection: CollectionReference = Firestore.firestore().collection("roadMapLevels")
//    
//    private func levelDocument(levelId: String) -> DocumentReference {
//        roadMapLevelsCollection.document(levelId)
//    }
// 
//    // загрузка Levels.........................................................
//    func uploadLevels(level: Level) async throws {
//        try levelDocument(levelId: level.id).setData(from: level, merge: false)
//    }
//    //.........................................................................
//    
//    
//    func getLevel(levelId: String) async throws -> Level {
//        try  await levelDocument(levelId: levelId).getDocument(as: Level.self)
//    }
//        
//    func getRoadMapLevels() async throws -> [Level] {
//        try await roadMapLevelsCollection.getDocuments(as: Level.self)
//    }
//    
//    
//    
//    // MARK: - Tips...
//    private let tipsCollection = Firestore.firestore().collection("tips")
//    
//    private func tipDocument(tipId: String) -> DocumentReference {
//        tipsCollection.document(tipId)
//    }
//    
////    func uploadTips(tip: Tip) async throws {
////        try tipDocument(tipId: tip.id).setData(from: tip, merge: false)
////    }
//    func getTip(tipId: String) async throws -> Tip {
//        try  await tipDocument(tipId: tipId).getDocument(as: Tip.self)
//    }
//    func getTips() async throws -> [Tip] {
//        try await tipsCollection.getDocuments(as: Tip.self)
////        let snapshot = try await tipsCollection.getDocuments()
////        
////        var tips: [Tip] = []
////        
////        for document in snapshot.documents {
////            let tip = try document.data(as: Tip.self)
////            tips.append(tip)
////        }
////        
////        return tips
//    }
//
//}
