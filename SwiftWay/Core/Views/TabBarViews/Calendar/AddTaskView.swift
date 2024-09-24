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

struct StartDateWithTime: View {
    @Binding var date: Date

    var body: some View {
        DatePicker(
            "Task Date: ",
            selection: $date,
            in: Date.now...,
            displayedComponents: [.date, .hourAndMinute]
        )
    }
}
