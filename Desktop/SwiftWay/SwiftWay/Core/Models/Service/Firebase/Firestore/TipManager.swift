//
//  TipManager.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 13.04.24.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class TipManager {
    
    static let shared = TipManager()
    private init() { }
    
    private let tipsCollection = Firestore.firestore().collection("tips")

    private func tipDocument(tipId: String) -> DocumentReference {
        tipsCollection.document(tipId)
    }

//    func uploadTips(tip: Tip) async throws {
//        try tipDocument(tipId: tip.id).setData(from: tip, merge: false)
//    }
    
    func getTip(tipId: String) async throws -> Tip {
        try  await tipDocument(tipId: tipId).getDocument(as: Tip.self)
    }
    
    func getTips() async throws -> [Tip] {
        try await tipsCollection.getDocuments(as: Tip.self)
//        let snapshot = try await tipsCollection.getDocuments()
//
//        var tips: [Tip] = []
//
//        for document in snapshot.documents {
//            let tip = try document.data(as: Tip.self)
//            tips.append(tip)
//        }
//
//        return tips
    }
    
}
