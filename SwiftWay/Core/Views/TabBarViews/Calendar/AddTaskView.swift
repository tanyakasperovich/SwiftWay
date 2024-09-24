//
//  AddTaskView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 9.01.24.
//

import SwiftUI

struct AddTaskView: View {
    // MARK: -
    @State var titleFieldText: String = ""
    @State var descriptionFieldText: String = ""
    @State private var date = Date()
    @State private var items: [Item] = []
    @Binding var selectedView: Bool
    @Binding var showAddTaskView: Bool
    @EnvironmentObject var viewModel: ProfileViewModel

    @State var itemFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
        
                TasksPickerView(selectedView: $selectedView)
                    .padding(.bottom)
                
                HStack {
                    Text(selectedView ? "Add New Education Task:" : "Add New Work Task...")
                        .bold()
                    Spacer()
                }
                
                VStack(spacing: 15) {
                    TextField("Add title here...", text: $titleFieldText)
                    // .textInputAutocapitalization(.words)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(15)
                    
                    TextField("Add task here...", text: $descriptionFieldText)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 150)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(15)
                   
                    StartDateWithTime(date: $date)
                        .accentColor(.theme.iceColor)
                        .bold()
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("ToDo List: ")
                                .bold()
                            Spacer()
                        }
                        
                        Text("Click the add button and add a bunch of items to your todo list.")
                            .foregroundColor(.secondary)
                        
                        if !items.isEmpty {
                                ForEach(items) { item in
                                    HStack(alignment: .top) {
                                        Image(systemName: "checkmark.rectangle.portrait")
                                            .foregroundColor(selectedView ? .theme.darkPinkColor : .theme.iceColor)
                                        Text(item.title)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                        }
                        
                        HStack {
                            TextField("Add item here...", text: $itemFieldText)
                                .font(.headline)
                                .padding(.leading)
                                .frame(height: 55)
                                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                .cornerRadius(15)
                         
                            
                            Button { 
                                items.append(Item(title: itemFieldText, isCompleted: false))
                                itemFieldText = ""
                            } label: {
                                PBView(content: Text("Save").padding(7), color: selectedView ? .theme.darkPinkColor : .theme.iceColor, isSet: .constant(true))
                                
                               // PrimaryButton(text: "Save", backgroundColor: selectedView ? .theme.darkPinkColor : .theme.iceColor, textColor: Color.white.opacity(0.9))
                                
                                        .frame(height: 55)
                                        .frame(width: 75)
                                        .blur(radius: disableFormItem ?  1.5 : 0.0)
                                        .disabled(disableFormItem)
                                }
                        }
//                        
//                        Button {
//                            
//                        } label: {
//                            PrimaryButton(text: "+ Add Item", backgroundColor: selectedView ? .theme.darkPinkColor : .theme.iceColor, textColor: Color.white.opacity(0.9))
//                                .frame(height: 55)
//                        }
                        
                      
                    }
                
                    Button(action: {
                        guard !titleFieldText.isEmpty else { return }
                        viewModel.addUserTask(task: UserTask(title: titleFieldText, time: date, disclosureExpanded: false, description: descriptionFieldText, dateCreated: Date.now, educationTask: selectedView, items: items, professionId: viewModel.user?.selectedProfession ?? ""))
                        titleFieldText = ""
                        descriptionFieldText = ""
                        date = Date()
                        selectedView = true
                        items = []
                        showAddTaskView = false
                    }, label: {
                        ZStack {
                            RoundedRectangleShape(color: selectedView ? .theme.darkPinkColor : .theme.iceColor)
                                .opacity(disableForm ? 0.7 : 1)
                                .frame(height: 55)
                                .shadow(color: Color.black, radius: 2, x: -1, y: 1)
                            
                            Text("Save Task")
                                .textCase(.uppercase)
                                .bold()
                                .font(.title3)
                                .foregroundColor(disableForm ? .white : .white)
                                .padding()
                                .blur(radius: disableForm ?  1.5 : 0.0)
                        }
                    })
                    .disabled(disableForm)
                    .padding(.horizontal)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
    }
    
    var disableForm: Bool {
        titleFieldText.count < 3
    }
    
    var disableFormItem: Bool {
        itemFieldText.count < 3
    }
    
    // MARK: - FUNCTIONS...
//    func saveButtonPressed() {
//        if textIsAppropriate() {
//            itemViewModel.addItem(title: itemFieldText)
//            
//        }
//    }
//    
//    func textIsAppropriate() -> Bool {
//        if itemFieldText.count < 3 {
//            alertTitle = "Your new todo item must be at least 3 characters long!!! 😨😰😱"
//            showAlert.toggle()
//            return false
//        }
//        return true
//    }
//    
//    func getAlert() -> Alert {
//        return Alert(title: Text(alertTitle))
//    }
}

#Preview {
    AddTaskView(selectedView: .constant(true), showAddTaskView: .constant(true))
        .environmentObject(ProfileViewModel())
}


// MARK: - Tasks Picker View.....
struct TasksPickerView: View {
    @Binding var selectedView: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedView = true
                } label: {
                    Image(systemName: "book.fill")
                        .foregroundColor(selectedView ? .white : .secondary)
                        .padding()
                        .padding(.horizontal)
                        .background(RoundedRectangleShape(color: .theme.darkPinkColor) .opacity(selectedView ? 1 : 0))
                }

                Button {
                    selectedView = false
                } label: {
                    Image(systemName: "macbook.and.iphone")
                        .foregroundColor(selectedView ? .secondary : .white)
                        .padding()
                        .padding(.horizontal)
                        .background(RoundedRectangleShape(color: .theme.iceColor)
                            .opacity(selectedView ? 0 : 1))
                }
            }
            .background(RoundedRectangleShape(color: selectedView ? .theme.darkPinkColor : .theme.iceColor).opacity(0.2))
        }
    }
}

// MARK: - Start Date...

//struct StartDate: View {
//    @State private var date = Date()
//    
//    var body: some View {
//        DatePicker(
//            "Start Date",
//            selection: $date,
//            in: Date.now...,
//            displayedComponents: [.date]
//        )
//        
//        Text("\(date.formatted(date: .long, time: .omitted))")
//    }
//}

struct StartDateWithTime: View {
    @Binding var date: Date
    //    let dateRange: ClosedRange<Date> = {
    //        let calendar = Calendar.current
    //        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
    //        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
    //        return calendar.date(from:startComponents)!
    //            ...
    //            calendar.date(from:endComponents)!
    //    }()
    
    var body: some View {
        DatePicker(
            "Task Date: ",
            selection: $date,
            in: Date.now...,
            displayedComponents: [.date, .hourAndMinute]
        )
    }
}

//// MARK: - Add Tasks Card View...
//struct AddTasksCardView: View {
//    @Binding var showAddEducationTaskView: Bool
//    @Binding var showAddWorkTaskView: Bool
//    @Binding var selectedView: Bool
//
//    var body: some View {
//            HStack{
//                Button {
//                    if selectedView {
//                        showAddEducationTaskView = true
//                    } else {
//                        showAddWorkTaskView = true
//                    }
//                } label: {
//                    CirclePrimaryButton(imageName: "plus", backgroundColor: selectedView ? .theme.darkPinkColor : .theme.iceColor, imageColor: .white)
//                }
//        }
//        .sheet(isPresented: $showAddEducationTaskView, content: {
//            AddEducationTaskView(showAddEducationTaskView: $showAddEducationTaskView)
//                .presentationDetents([.large, .large])
//                .presentationDragIndicator(.visible)
//        })
//        .sheet(isPresented: $showAddWorkTaskView, content: {
//            AddWorkTaskView(showAddWorkTaskView: $showAddWorkTaskView)
//                .presentationDetents([.large, .large])
//                .presentationDragIndicator(.visible)
//        })
//    }
//}

//// MARK: - Add Tasks View...
//struct AddEducationTaskView: View {
//    @EnvironmentObject var viewModel: ProfileViewModel
//
//    @State var titleFieldText: String = ""
//    @State var descriptionFieldText: String = ""
//    @State var selectEducationTask: Bool = true
//
//    @Binding var showAddEducationTaskView: Bool
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack {
//                Text("Add Learn Task")
//                    .foregroundColor(.theme.darkPinkColor)
//                    .bold()
//
//                VStack(spacing: 20) {
//                    TextField("Add title here...", text: $titleFieldText)
//                    // .textInputAutocapitalization(.words)
//                        .font(.headline)
//                        .padding(.leading)
//                        .frame(height: 55)
//                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
//                        .cornerRadius(15)
//                        .padding(.horizontal)
//
//                    Button(action: {
//                        guard !titleFieldText.isEmpty else { return }
//                        viewModel.addUserTask(task: UserTask(title: titleFieldText, time: Date.now, disclosureExpanded: false, description: descriptionFieldText, taskDate: Date.now, educationTask: selectEducationTask))
//                        titleFieldText = ""
//                        descriptionFieldText = ""
//                        selectEducationTask = true
//                        showAddEducationTaskView = false
//                    }, label: {
//                        ZStack {
//                            RoundedRectangleShape(color: Color.theme.darkPinkColor)
//                                .opacity(disableForm ? 0.7 : 1)
//                                .frame(height: 55)
//                                .shadow(color: Color.black, radius: 2, x: -1, y: 1)
//
//                            Text("Save")
//                                .font(.headline)
//                                .foregroundColor(disableForm ? .secondary : .white)
//                                .padding()
//                        }
//                    })
//                    .disabled(disableForm)
//                    .padding(.horizontal)
//                }
//                .padding(.top)
//            }
//            .padding(.top)
//        }
//    }
//
//    var disableForm: Bool {
//        titleFieldText.count < 3
//    }
//
//}
//
//struct AddWorkTaskView: View {
//    @EnvironmentObject var viewModel: ProfileViewModel
//
//    @State var titleFieldText: String = ""
//    @State var descriptionFieldText: String = ""
//    @State var selectEducationTask: Bool = false
//
//    @Binding var showAddWorkTaskView: Bool
//
//    @State private var date = Date()
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack {
//                Text("Add Work Task")
//                    .foregroundColor(.theme.iceColor)
//                    .bold()
//
//                VStack(spacing: 20) {
//                    TextField("Add title here...", text: $titleFieldText)
//                    // .textInputAutocapitalization(.words)
//                        .font(.headline)
//                        .padding(.leading)
//                        .frame(height: 55)
//                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
//                        .cornerRadius(15)
//                        .padding(.horizontal)
//
//                    StartDateWithTime(date: $date)
//                        .accentColor(.theme.iceColor)
//
//                    Button(action: {
//                        guard !titleFieldText.isEmpty else { return }
//                        viewModel.addUserTask(task: UserTask(title: titleFieldText, time: date, disclosureExpanded: false, description: descriptionFieldText, taskDate: Date.now, educationTask: selectEducationTask))
//                        titleFieldText = ""
//                        descriptionFieldText = ""
//                        selectEducationTask = false
//                        titleFieldText = ""
//                        showAddWorkTaskView = false
//                    }, label: {
//                        ZStack {
//                            RoundedRectangleShape(color: Color.theme.iceColor)
//                                .opacity(disableForm ? 0.7 : 1)
//                                .frame(height: 55)
//                                .shadow(color: Color.black, radius: 2, x: -1, y: 1)
//
//                            Text("Save")
//                                .font(.headline)
//                                .foregroundColor(disableForm ? .secondary : .white)
//                                .padding()
//                        }
//                    })
//                    .disabled(disableForm)
//                    .padding(.horizontal)
//                }
//                .padding(.top)
//            }
//            .padding(.top)
//        }
//    }
//
//    var disableForm: Bool {
//        titleFieldText.count < 3
//    }
//
//}
