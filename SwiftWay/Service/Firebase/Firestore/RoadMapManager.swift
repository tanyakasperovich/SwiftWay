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

    // MARK: - Sectors...
    private let roadMapCollection: CollectionReference = Firestore.firestore().collection("sectors")

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
  
    // MARK: - Levels....
        private let levelsCollection: CollectionReference = Firestore.firestore().collection("levels")
    
        private func levelDocument(levelId: String) -> DocumentReference {
            levelsCollection.document(levelId)
        }
    
        // загрузка Levels.........................................................
        func uploadLevels(level: Level) async throws {
            try levelDocument(levelId: level.id).setData(from: level, merge: false)
        }
        //.........................................................................
    
        func getLevel(levelId: String) async throws -> Level {
            try  await levelDocument(levelId: levelId).getDocument(as: Level.self)
        }
    
        func getAllLevels() async throws -> [Level] {
            try await levelsCollection.getDocuments(as: Level.self)
        }
    
    private func getAllLevelsQuery() -> Query {
        levelsCollection
    }
    
//    private func getAllLevelsSortedByPriceQuery(descending: Bool) -> Query {
//        levelsCollection
//            .order(by: Level.CodingKeys..rawValue, descending: descending)
//    }
    
    private func getAllLevelsForProfessionsQuery(professionId: String) -> Query {
        levelsCollection
            .whereField(Level.CodingKeys.professionId.rawValue, isEqualTo: professionId)
    }
    
//    private func getAllLevelsByPriceAndCategoryQuery(descending: Bool, category: String) -> Query {
//        levelsCollection
//            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
//            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
//    }
    
    func getAllLevels(forProfession professionId: String?, count: Int, lastDocument: DocumentSnapshot?) async throws -> (levels: [Level], lastDocument: DocumentSnapshot?) {
        var query: Query = getAllLevelsQuery()
//        func getAllLevels(priceDescending descending: Bool?, forCategory category: String?, count: Int, lastDocument: DocumentSnapshot?) async throws -> (products: [Product], lastDocument: DocumentSnapshot?) {
//            var query: Query = getAllProductsQuery()
//        if let descending, let category {
//            query = getAllProductsByPriceAndCategoryQuery(descending: descending, category: category)
//        } else if let descending {
//            query = getAllProductsSortedByPriceQuery(descending: descending)
      //  } else
            if let professionId {
            query = getAllLevelsForProfessionsQuery(professionId: professionId)
        }
        
        return try await query
            .startOptionally(afterDocument: lastDocument)
            .getDocumentsWithSnapshot(as: Level.self)
    }

}

//// MARK: - Levels....
//private func levelCollection(sectorId: String, professionId: String) -> CollectionReference {
//    professionDocument(sectorId: sectorId, professionId: professionId).collection("levels")
//}
//
//private func levelDocument(sectorId: String, professionId: String, levelId: String) -> DocumentReference {
//    levelCollection(sectorId: sectorId, professionId: professionId).document(levelId)
//}
//
//// загрузка Levels.........................................................
//func uploadLevels(sector: Sector, profession: Profession, level: Level) async throws {
//    try levelDocument(sectorId: sector.id, professionId: profession.id, levelId: level.id).setData(from: level, merge: false)
//}
////.........................................................................
//
//func getLevels(sectorId: String, professionId: String) async throws -> [Level] {
//    try await levelCollection(sectorId: sectorId, professionId: professionId).getDocuments(as: Level.self)
//}

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

