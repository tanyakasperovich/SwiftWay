//
//  RatingSubCategoryView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 4.12.23.
//

import SwiftUI

struct RatingSubCategoryView: View {
    
    var ratingQuize: Double
    
    var body: some View {
        HStack {
            RoundedRectangleShape(color: ratingQuize > 66 ? Color.green : (ratingQuize > 33 ? Color.yellow : Color.red))
            RoundedRectangleShape(color: ratingQuize > 66 ? Color.green : (ratingQuize > 33 ? Color.yellow : Color.red))
            RoundedRectangleShape(color: ratingQuize > 66 ? Color.green : (ratingQuize > 33 ? Color.yellow : Color.red))
        }
        .frame(width: 60, height: 3)
    }
}

#Preview {
    RatingSubCategoryView(ratingQuize: 75)
}
