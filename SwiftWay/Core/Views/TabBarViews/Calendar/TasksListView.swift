//
//  TasksListView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.01.24.
//

import SwiftUI

struct TasksListView: View {
    var viewModel: TaskViewModel
    
    @State private var selectedView = true
    @State private var showAddTaskView = false
    // @State private var showAddWorkTaskView = false
    
    @State private var disclosureExpanded = false
    @Binding var currentDate: Date
    @State var selectedTask: Bool = true
    
    var body: some View {
        VStack {
            let tasks = viewModel.userTasks.filter ({ userTask in
                return isSameDay(date1: userTask.time, date2: currentDate)
            })
            
        if !tasks.isEmpty {
                ForEach(tasks) { task in
                    TaskView(disclosureExpanded: $disclosureExpanded, task: task)
                        .contextMenu {
                            Button("Remove from my tasks") {
                                viewModel.removeUserTask(taskId: task.id)
                            }
                        }
                }
           } else {
                Text("Not found...")
           }
//                         if let task = viewModel.userTasks.first(where: { task in
//                                        return isSameDay(date1: task.time, date2: currentDate)}){
//            
//                                TaskView(disclosureExpanded: $disclosureExpanded, task: task)
//                                    .contextMenu {
//                                        Button("Remove from my tasks") {
//                                            viewModel.removeUserTask(taskId: task.id)
//                                        }
//                                    }
//                  }
//                                   else {
//                                       Text("Not found...")
//                                   }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddTaskView = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .navigationTitle("My Tasks")
//        .onAppear {
//                    viewModel.getUserTasks()
//                }
        .sheet(isPresented: $showAddTaskView, content: {
            AddTaskView(selectedView: $selectedTask, showAddTaskView: $showAddTaskView)
        })
    }
    
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}

#Preview {
    TasksListView(viewModel: TaskViewModel(), currentDate: .constant(Date.now))
}


