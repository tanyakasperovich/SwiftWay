//
//  HeaderView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 29.11.23.
//

import SwiftUI

// MARK: - Header Home View...
struct HeaderView: View {
    @State private var showButtonsBar: Bool = false
    @Binding var showAddEducationTaskView: Bool
    @Binding var showAddWorkTaskView: Bool
    @Binding var selectedProfession: Professions
    
    var body: some View {
        HStack(alignment: .top) {
            
            ButtonsBar_HeaderHomeView(showButtonsBar: $showButtonsBar, showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView)
            
            Spacer()
           // SearchBar_HeaderHomeView(showButtonBar: $showButtonsBar)
           //     .frame(height: 50)
            
            Picker_HeaderHomeView(showButtonBar: $showButtonsBar, selectedProfession: $selectedProfession)
                .padding(.vertical, showButtonsBar ? 5 : 0)
            
            Spacer()
            
            ItemButton_HeaderHomeView()
                .padding(.vertical, showButtonsBar ? 5 : 0)
        }
        .padding(.vertical, showButtonsBar ? 0 : 5)
    }
}

// MARK: - Buttons Bar View...
struct ButtonsBar_HeaderHomeView: View {
    @Binding var showButtonsBar: Bool
    
    @State private var showAddNoteView: Bool = false
    @Binding var showAddEducationTaskView: Bool
    @Binding var showAddWorkTaskView: Bool
    
    var body: some View {
               ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                showButtonsBar = showButtonsBar ? false : true
                            }
                        } label: {
                            ButtonView(content:
                                        VStack {
                                Image(systemName: showButtonsBar ? "chevron.left" : "plus")
                                    .foregroundStyle(Color.theme.fontColor)
                                    .frame(width: 32, height: 32)
                            },
                                       backgroundColor: .accentColor)
                        }
                        
                        if showButtonsBar {
                            HStack {
                                Button {
                                    showAddEducationTaskView = true
                                } label: {
                                    ButtonView(content:
                                                VStack {
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color.theme.fontColorWB)
                                            .frame(width: 32, height: 32)
                                    },
                                               backgroundColor: .theme.darkPinkColor)
                                    
                                }
                                
                                Button {
                                    showAddWorkTaskView = true
                                } label: {
                                    ButtonView(content:
                                                VStack {
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color.theme.fontColorWB)
                                            .frame(width: 32, height: 32)
                                    },
                                               backgroundColor: .theme.iceColor)
                                }
                                
                                Button {
                                    showAddNoteView = true
                                } label: {
                                    ButtonView(content:
                                                VStack {
                                        Image(systemName: "square.and.pencil")
                                            .foregroundStyle(Color.theme.fontColorWB)
                                            .frame(width: 32, height: 32)
                                    },
                                               backgroundColor: .accentColor)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.leading, showButtonsBar ? 10 : 0)
                    .padding(.vertical, showButtonsBar ? 5 : 0)
                    .background(
                        RoundedRectangleShape(color: .accentColor.opacity(0.2))
                    )
          }
        .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(color: Color.accentColor, showAddNoteView: $showAddNoteView)
        })
    }
}

// MARK: - Search Bar View...
//struct SearchBar_HeaderHomeView: View {
//    @State private var searchText: String = ""
//    @Binding var showButtonBar: Bool
//    
//    var body: some View {
//        //  if showButtonBar {
//        
//        Button {
//            withAnimation {
//                showButtonBar = false
//            }
//        } label: {
//            ZStack {
//                RoundedRectangleShape(color: showButtonBar ? .accentColor : .accentColor.opacity(0.2))
//                    .shadow(color: showButtonBar ? Color.black : .clear, radius: 2, x: 0, y: 2)
//                
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(showButtonBar ? .white : .accentColor)
//                    
//                    if !showButtonBar {
//                        TextField("Search...", text: $searchText)
//                        
//                        if searchText != "" {
//                            Button {
//                                searchText = ""
//                            } label: {
//                                Image(systemName: "xmark")
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, showButtonBar ? 0 : 15)
//            }
//        }
//    }
//}

// MARK: - Picker View...
struct Picker_HeaderHomeView: View {
    
    @Binding var showButtonBar: Bool
    @Binding var selectedProfession: Professions
    
    var body: some View {
        Button {
            withAnimation {
                showButtonBar = false
            }
        } label: {
            ZStack {
                RoundedRectangleShape(color: showButtonBar ? .accentColor : .accentColor.opacity(0.2))
                    .shadow(color: showButtonBar ? Color.black : .clear, radius: 2, x: 0, y: 2)
                
                if showButtonBar {
                        HStack {
                            Image(systemName: "list.bullet")
                                .padding(.horizontal)
                                .foregroundStyle(Color.theme.fontColor)
                        }
                    } else {
                        Picker("", selection: $selectedProfession) {
                            ForEach(Professions.allCases, id: \.self){profession in
                                HeaderText(text: profession.rawValue, color: .theme.fontColor)
                            }
                        }
                        .accentColor(.theme.fontColor)
                        .pickerStyle(.menu)
                    }
            }
            .frame(height: 48)
        }
    }
}

// MARK: - ItemButton View...
struct ItemButton_HeaderHomeView: View {
    var body: some View {
        Button {
//
        } label: {
            ButtonView(content:
                        VStack {
                Image(systemName: "play.fill")
                    .foregroundStyle(Color.theme.fontColor)
                    .frame(width: 32, height: 32)
            },
                       backgroundColor: .accentColor)
        }
    }
}

#Preview {
    VStack {
        HeaderView(showAddEducationTaskView: .constant(false), showAddWorkTaskView: .constant(false), selectedProfession: .constant(.iosDeveloper))
            .padding(.horizontal, 3)
        Spacer()
    }
}
