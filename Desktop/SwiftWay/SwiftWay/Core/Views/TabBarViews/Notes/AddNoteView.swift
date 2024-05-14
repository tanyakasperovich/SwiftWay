//
//  AddNoteView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

struct AddNoteView: View {
    @State var titleFieldText: String = ""
    @State var descriptionFieldText: String = ""
    var color: Color
    @Binding var showAddNoteView: Bool
    
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Add new note...")
                    .bold()
                VStack(spacing: 20) {
                    TextField("Add title here...", text: $titleFieldText)
                    // .textInputAutocapitalization(.words)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    TextField("Add note here...", text: $descriptionFieldText)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 150)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
//                    HStack {
////                        Button {
////                            selecledColor = .accent
////                        } label: {
////                            ZStack {
////                                RoundedRectangleShape(color: Color.accentColor)
////                                    .frame(width: 40, height: 40)
////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
////                                
////                                RoundedRectangleShape(color: selecledColor == .accent ? Color.white : Color.accentColor)
////                                    .frame(width: 15, height: 15)
////                            }
////                        }
////                        Button {
////                            selecledColor = .swift
////                        } label: {
////                            ZStack {
////                                RoundedRectangleShape(color: Color.theme.orangeColor)
////                                    .frame(width: 40, height: 40)
////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
////                                
////                                RoundedRectangleShape(color: selecledColor == .swift ? Color.white : Color.theme.orangeColor)
////                                    .frame(width: 15, height: 15)
////                            }
////                        }
////                        Button {
////                            selecledColor = .swiftUI
////                        } label: {
////                            ZStack {
////                                RoundedRectangleShape(color: Color.theme.purpleColor)
////                                    .frame(width: 40, height: 40)
////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
////                                
////                                RoundedRectangleShape(color: selecledColor == .swiftUI ? Color.white : Color.theme.purpleColor)
////                                    .frame(width: 15, height: 15)
////                            }
////                        }
////                        Button {
////                            selecledColor = .uIKit
////                        } label: {
////                            ZStack {
////                                RoundedRectangleShape(color: Color.theme.blueColor)
////                                    .frame(width: 40, height: 40)
////                                    .shadow(color: Color.black, radius: 1, x: 0, y: 1)
////                                
////                                RoundedRectangleShape(color: selecledColor == .uIKit ? Color.white : Color.theme.blueColor)
////                                    .frame(width: 15, height: 15)
////                            }
////                        }
//                        
//                    }
                    
                    Button(action: {
                        guard !titleFieldText.isEmpty else { return }
                        viewModel.addUserNote(note: UserNote(title: titleFieldText, description: descriptionFieldText, url: "", dateCreated: Date.now, professionId: viewModel.user?.selectedProfession ?? ""))
                        titleFieldText = ""
                        descriptionFieldText = ""
                        showAddNoteView = false
                    }, label: {
                        ZStack {
                            RoundedRectangleShape(color: color)
                                .opacity(disableForm ? 0.7 : 1)
                                .frame(height: 55)
                                .shadow(color: Color.black, radius: 2, x: -1, y: 1)
                            
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(disableForm ? .secondary : .white)
                                .padding()
                        }
                    })
                    .disabled(disableForm)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .padding(.top)
        }
    }
    
    var disableForm: Bool {
        titleFieldText.count < 3
    }
}

#Preview {
    AddNoteView(color: Color.accentColor, showAddNoteView: .constant(false))
        .environmentObject(ProfileViewModel())
}
