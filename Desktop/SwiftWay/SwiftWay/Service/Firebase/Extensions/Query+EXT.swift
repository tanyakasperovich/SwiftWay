//
//  Query+EXT.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 1.12.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

extension Query {

    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        try await getDocumentsWithSnapshot(as: type).tips
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (tips: [T], lastDocument: DocumentSnapshot?) where T : Decodable {
        let snapshot = try await self.getDocuments()

        let tips = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })

        return (tips, snapshot.documents.last)
    }
    
//    func startOptionally(afterDocument lastDocument: DocumentSnapshot?) -> Query {
//        guard let lastDocument else { return self }
//        return self.start(afterDocument: lastDocument)
//    }
//
//    func aggregateCount() async throws -> Int {
//        let snapshot = try await self.count.getAggregation(source: .server)
//        return Int(truncating: snapshot.count)
//    }

    func addSnapshotListener<T>(as type: T.Type) -> (AnyPublisher<[T], Error>, ListenerRegistration) where T : Decodable {
        let publisher = PassthroughSubject<[T], Error>()

        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            let tips: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            publisher.send(tips)
        }

        return (publisher.eraseToAnyPublisher(), listener)
    }

}

