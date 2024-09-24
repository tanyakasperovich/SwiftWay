//
//  StaggeredGrid.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct StaggeredGrid<Content: View,T: Identifiable>: View
where T: Hashable {
    
    // It will return each object from collection to build View...
    var content: (T) -> Content
    
    var list: [T]
    
    // Columns...
    var columns: Int
    
    // Properties...
    var showIndicators: Bool
    var spacing: CGFloat
    
    init(columns: Int, showIndicators: Bool = false, spacing: CGFloat = 10, list: [T],@ViewBuilder content: @escaping (T)->Content){
        self.content = content
        self.list = list
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.columns = columns
    }
    
    // Staggered Grid Function...
    func setUpList()->[[T]]{
               
        // creating empty sub arrays of columns count...
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spiliting array for VStack oriented View...
        var currentIndex: Int = 0
        
        for object in list{
            gridArray[currentIndex].append(object)
            
            // increasing index count...
            // and resetting if overbounds the columns count...
            if currentIndex == (columns - 1){
                currentIndex = 0
            }
            else{
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
       
        HStack(alignment: .top, spacing: 10){
            
            ForEach(setUpList(), id: \.self){columnsData in
                
                // For Optimized Using LazyStack...
                LazyVStack(spacing: spacing){
                    
                    ForEach(columnsData){object in
                        content(object)
                    }
                }
                .padding(.top,getIndex(values: columnsData) == 1 ? 20:0)
                .padding(.top,getIndex(values: columnsData) == 2 ? 40:0)
            }
        }
        
        // only vertical padding...
        // horizontal padding will be user's optional...
        .padding(.vertical)
    }
    
    // Moving Second row little Down...
    func getIndex(values: [T])->Int{
        
        let index = setUpList().firstIndex { t in
            return t == values
            
        } ?? 0
        
        return index
    }
}
