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
    var sectorColor: String
    
    var body: some View {
        HStack(alignment: .top) {
            
            ButtonsBar_HeaderHomeView(showButtonsBar: $showButtonsBar, showAddEducationTaskView: $showAddEducationTaskView, showAddWorkTaskView: $showAddWorkTaskView, color: Color(sectorColor))
            
            Spacer()
           // SearchBar_HeaderHomeView(showButtonBar: $showButtonsBar)
           //     .frame(height: 50)

            Picker_HeaderHomeView(showButtonBar: $showButtonsBar)
                .frame(height: 48)
                .padding(.vertical, showButtonsBar ? 5 : 0)
            
            Spacer()
            
            ItemButton_HeaderHomeView(color: Color(sectorColor))
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
    
    var color: Color
    
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
                                       backgroundColor: color)
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
                                               backgroundColor: color)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.leading, showButtonsBar ? 10 : 0)
                    .padding(.vertical, showButtonsBar ? 5 : 0)
                    .background(
                        RoundedRectangleShape(color: color.opacity(showButtonsBar ? 0.2 : 0.0))
                    )
          }
        .sheet(isPresented: $showAddNoteView, content: {
            AddNoteView(color: color, showAddNoteView: $showAddNoteView)
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
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
                if showButtonBar {
                    Button {
                        showButtonBar = false
                    } label: {
                        ZStack {
                            RoundedRectangleShape(color: showButtonBar ? Color(roadMapViewModel.selectedProfession?.color ?? "Lime") : Color(roadMapViewModel.selectedProfession?.color ?? "Lime").opacity(0.2))
                                .shadow(color: showButtonBar ? Color.black : .clear, radius: 2, x: 0, y: 2)
                            HStack {
                                Image(systemName: "list.bullet")
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.theme.fontColor)
                            }
                        }
                    }
                } else {
                    ZStack {
                        RoundedRectangleShape(color: Color(roadMapViewModel.selectedProfession?.color ?? "Lime").opacity(0.2))
                        
                        VStack {
                            if roadMapViewModel.isLoadingSectors {
                                ProgressView()
                            } else {
                                Menu(roadMapViewModel.selectedProfession?.title ?? "Select Profession") {
                                    ForEach(roadMapViewModel.sectors, id: \.self) {sector in
                                        Menu(sector.title ?? "") {
                                            ForEach(sector.professions ?? [], id: \.self) {profession in
                                                Button {
                                                    Task {
                                                        try? await roadMapViewModel.professionSelected(option: profession.id)
                                                        profileViewModel.updateUserSelectedProfession(selectedProfession: profession.id)
                                                    }
                                                    
                                                    withAnimation {
                                                        roadMapViewModel.selectedProfession = profession
                                                        }
                                                } label: {
                                                    if let professionTitle = profession.title {
                                                        HeaderText(text: professionTitle, color: .theme.fontColor)
                                                        Spacer()
                                                        Image(systemName: profileViewModel.user?.selectedProfession == profession.id ? "checkmark" : "")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .accentColor(.theme.fontColor)
                            }
                        }
                        .onFirstAppear {
                            Task {
                                try? await roadMapViewModel.getSectors()
                                try? await roadMapViewModel.setProfession(professionId: profileViewModel.user?.selectedProfession ?? "")
                                try? await roadMapViewModel.professionSelected(option: profileViewModel.user?.selectedProfession ?? "")
                            }
                        }
                    }
                }
        
    }
}

// MARK: - ItemButton View...
struct ItemButton_HeaderHomeView: View {
    var color: Color
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
                       backgroundColor: color)
        }
    }
}

#Preview {
    VStack {
        let roadMapViewModel = RoadMapViewModel()
        HeaderView(showAddEducationTaskView: .constant(false), showAddWorkTaskView: .constant(false), sectorColor: "SectorIT")
            .padding(.horizontal, 3)
        Spacer()
    }
}
