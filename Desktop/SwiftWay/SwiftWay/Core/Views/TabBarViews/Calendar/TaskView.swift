//
//  TaskView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.01.24.
//

import SwiftUI

struct TaskView: View {
    @Binding var disclosureExpanded: Bool

    var task: UserTask
    @State private var isDone = false
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
       // formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 10) {
            DisclosureGroup(
                isExpanded: $disclosureExpanded,
                content: {
                    VStack(alignment: .center) {
                        Text(task.description ?? "")
                            .padding(.bottom)
                        
                        if !task.items.isEmpty {
                            HStack(alignment: .top) {
                                Text("List: ")
                                    .foregroundStyle(Color.theme.fontColorBW)
                                
                                VStack(alignment: .leading) {
                                    ForEach(task.items, id: \.id) { item in
                                        HStack() {
                                            Button {
                                                // update......
                                                isDone.toggle()
                                            } label: {
                                               
                                                HStack(alignment: .top) {
                                                    if item.isCompleted {
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor((task.educationTask ?? false) ? .theme.darkPinkColor : .theme.iceColor)
                                                    } else {
                                                        Image(systemName: "circlebadge")
                                                            .foregroundColor((task.educationTask ?? false) ? .theme.darkPinkColor : .theme.iceColor)
                                                    }
                                                    
                                                    Text(item.title)
                                                        .foregroundStyle(Color.theme.fontColorBW)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.secondary)
                },
                label: {
                    HStack(alignment: .top) {
                        // For Custom Timing...
                        Text(timeFormatter.string(from: task.time))
                            .foregroundStyle(Color.theme.fontColorBW)
                        
                        Text(task.title ?? "")
                            .font(.title2.bold())
                            .padding(.horizontal)
                            .foregroundStyle(Color.theme.fontColorBW)
                    }
                }
            )
        }
        .padding(.vertical)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangleShape(color: (task.educationTask ?? false) ? .theme.darkPinkColor : .theme.iceColor)
                .opacity(0.2)
        )
    }
}

#Preview {
    TaskView(disclosureExpanded: .constant(true), task: UserTask(title: "Title titletitle title", time: Date(), disclosureExpanded: false, description: "Description descriptiondescription description description. description, description description.", dateCreated: Date(), educationTask: true, items: [Item(id: "id1", title: "Title 1", isCompleted: true), Item(id: "id2", title: "Title 2", isCompleted: false), Item(id: "id3", title: "Title 3", isCompleted: false)]))
}
