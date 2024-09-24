//
//  NoteEntityExtention.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 6.06.24.
//

import SwiftUI

// Handle nils and formattingextension
extension NoteEntity {
    var viewImage: UIImage {
        if let data = image, let image = UIImage(data: data) {
            return image
        } else {
            return UIImage(systemName: "note.text")!// SF Symbol
        }
    }
    
    var viewTitle: String {
        title ?? "No Book Title"
    }
    
}
