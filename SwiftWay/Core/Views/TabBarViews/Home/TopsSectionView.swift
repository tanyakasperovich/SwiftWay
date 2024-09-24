//
//  TopsSectionView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 29.11.23.
//

import SwiftUI

// MARK: - Model...
struct ChannelModel : Identifiable, Hashable {
    var id = UUID().uuidString
    let name: String
    let image: String
    let count: String
    let professionId: String
}

struct BookModel : Identifiable, Hashable {
    var id = UUID().uuidString
    let name: String
    let image: String
    let autore: String
    let professionId: String
}

struct CoursesModel : Identifiable, Hashable {
    var id = UUID().uuidString
    let name: String
    let image: String
    let autore: String
    let professionId: String
}

// MARK: - Tops View Model...
@MainActor
final class TopsViewModel: ObservableObject {
    // Tops...
    @Published var youTubeChannels: [ChannelModel] = [
    ChannelModel(name: "Channel Name 1", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 2", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 3", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 4", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 5", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 6", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 7", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 8", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 9", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
    ChannelModel(name: "Channel Name 10", image: "", count: "111", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024")
    ]
        
    @Published var books: [BookModel] = [
        BookModel(name: "Book Name 1", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 2", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 3", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 4", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 5", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 6", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 7", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 8", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 9", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        BookModel(name: "Book Name 10", image: "", autore: "Autore Name", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024")
    ]
    
    @Published var courses: [CoursesModel] = [
        CoursesModel(name: "Course Name 1", image: "", autore: "Course Autore", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        CoursesModel(name: "Course Name 2", image: "", autore: "Course Autore", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        CoursesModel(name: "Course Name 3", image: "", autore: "Course Autore", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        CoursesModel(name: "Course Name 4", image: "", autore: "Course Autore", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024"),
        CoursesModel(name: "Course Name 5", image: "", autore: "Course Autore", professionId: "FCC6983D-0AFF-49ED-9BA2-6B5DDBE09024")
    ]
    
    @Published var filteredYouTybeChanelsForProfession: [ChannelModel] = []
    @Published var filteredBooksForProfession: [BookModel] = []
    @Published var filteredCoursesForProfession: [CoursesModel] = []
    
    // Tops...
    func getYouTubeChannelsTops() async throws {
        //self.youTubeChannelsTops = try await RoadMapManager.shared.getRoadMapLevels()
    }
    
    func getBooksTops() async throws {
        //self.youTubeChannelsTops = try await RoadMapManager.shared.getRoadMapLevels()
    }
    
    func getCoursesTops() async throws {
        //self.youTubeChannelsTops = try await RoadMapManager.shared.getRoadMapLevels()
    }
    
    func filterYouTybeChanelsForProfession(selectedProfessionId: String) {
        self.filteredYouTybeChanelsForProfession = youTubeChannels.filter({$0.professionId == selectedProfessionId})
    }
    
    func filterBooksForProfession(selectedProfessionId: String) {
        self.filteredBooksForProfession = books.filter({$0.professionId == selectedProfessionId})
    }
    
    func filterCoursesForProfession(selectedProfessionId: String) {
        self.filteredCoursesForProfession = courses.filter({$0.professionId == selectedProfessionId})
    }
}

// MARK: - Tops View...
struct TopsSectionView: View {
    @StateObject private var topsViewModel = TopsViewModel()
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    @State var showSection: Bool = true
    var selectedProfessionId: String

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                showSection.toggle()
            } label: {
                HStack(alignment: .bottom) {
                    Image(systemName: "arrowshape.up.fill")
                        .foregroundStyle(Color.theme.fontColor.opacity(0.7))
                        .bold()
                        .padding(.trailing, 5)
                    
                    HeaderText(text: ("Tops").uppercased(), color: .theme.fontColorBW.opacity(0.7))

                    Spacer()
                    
                    Image(systemName: showSection ? "chevron.down" : "chevron.right")
                        .foregroundStyle(Color.theme.fontColorBW.opacity(0.7))
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            
            if showSection {
                HStack {
                    Top10YouTubeChannels_CardView(topsViewModel: topsViewModel, selectedProfessionId: selectedProfessionId)
                    
                    VStack {
                        // Books...
                        Top10Books_CardView(topsViewModel: topsViewModel, selectedProfessionId: selectedProfessionId)
                        
                        // Courses...
                        Top5Courses_CardView(topsViewModel: topsViewModel, selectedProfessionId: selectedProfessionId)
                    }
                }
            }
            

        }
       // .padding(.vertical, 10)
    }
}

#Preview {
    TopsSectionView(selectedProfessionId: "")
        .environmentObject(RoadMapViewModel())
}
    
// Top10YouTubeChanels...
struct Top10YouTubeChannels_CardView: View {
    @State private var showTop10YouTubeCannelsView: Bool = false
    var topsViewModel: TopsViewModel
    var selectedProfessionId: String
    
    var body: some View {
        VStack {
            Button {
                showTop10YouTubeCannelsView = true
                
                topsViewModel.filterYouTybeChanelsForProfession(selectedProfessionId: selectedProfessionId)
            } label: {
                CardView(content:
                            VStack(alignment: .leading) {
                    Text("🆎 YouTube каналы для обучения")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color.theme.fontColorBW)
                        .opacity(0.9)
                }
                         , color: .accentColor)
                    .padding(.top, 5)
                    .frame(height: 270)
                
                
            }
        }
        .sheet(isPresented: $showTop10YouTubeCannelsView, content: {
            Top10YouTubeChannelsView(topsViewModel: topsViewModel)
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct Top10YouTubeChannelsView: View {
    var topsViewModel: TopsViewModel
    
    var columns = [
        GridItem(.adaptive(minimum: 150))
    ]
            
    var body: some View {
        ScrollView {
            
            Text("Top \(topsViewModel.filteredYouTybeChanelsForProfession.count) YouTube Channels")
                .bold()
                .foregroundStyle(Color.black)
                .padding()
                .padding(.top)
            
            LazyVGrid(columns: columns) {
                ForEach(topsViewModel.filteredYouTybeChanelsForProfession, id: \.self) {channel in
                    CardView(content:
                                VStack(alignment: .leading) {
                        
                        // AsyncImage...
                        //                        AsyncImage(url: URL(string: "https://")) { photo in
                        //                            if let image = photo.image {
                        //                                image
                        //                                    .resizable()
                        //                                    .scaledToFit()
                        //                            } else if photo.error != nil {
                        //                                Text("There was an error loading the image.")
                        //                            } else {
                        //                                ProgressView()
                        //                            }
                        //                        }
                        //                         .frame(width: 100, height: 100)
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.gray.opacity(0.1))
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            // Name...
                            Text("\(channel.name)")
                                .font(.headline)
                                .foregroundStyle(.black)
                            Text("99 тыс. подписчиков")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }, color: .accentColor
                    )
                    .padding(.bottom, 5)
                }
            }
            .padding([.bottom, .top])
            .padding(.horizontal, 10)
        }
        .task {
            try? await topsViewModel.getYouTubeChannelsTops()
        }
    }
}

// Top10Books...
struct Top10Books_CardView: View {
    @State private var showTop10BooksView: Bool = false
    var topsViewModel: TopsViewModel
    var selectedProfessionId: String
    
    var body: some View {
        VStack {
            // Books...
            Button {
                showTop10BooksView = true
                topsViewModel.filterBooksForProfession(selectedProfessionId: selectedProfessionId)
            } label: {
                CardView(content:
                            VStack(alignment: .leading) {
                    Text("📚 Книги")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color.theme.fontColorBW)
                        .opacity(0.9)
                }
                         , color: .accentColor)
                    .padding(.top, 5)
                    .frame(height: 130)
            }
        }
        .sheet(isPresented: $showTop10BooksView, content: {
            Top10BooksView(topsViewModel: topsViewModel)
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct Top10BooksView: View {
    var topsViewModel: TopsViewModel
    
    var columns = [ GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            
            Text("Top \(topsViewModel.filteredBooksForProfession.count) Books")
                .bold()
                .foregroundStyle(Color.black)
                .padding()
                .padding(.top)
            LazyVGrid(columns: columns) {
                ForEach(topsViewModel.filteredBooksForProfession, id: \.self) {book in
                    CardView(content:
                                VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(book.autore)
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.secondary.opacity(0.2))
                        }
                        
                        // Name...
                        Text(book.name)
                            .font(.headline)
                            .foregroundStyle(.black)
                    }, color: .accentColor
                    )
                    .padding(.bottom, 5)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .task {
            try? await topsViewModel.getBooksTops()
        }
    }
}

// Top5Courses...
struct Top5Courses_CardView: View {
    @State private var showTop5CoursesView: Bool = false
    var topsViewModel: TopsViewModel
    var selectedProfessionId: String
    
    var body: some View {
        VStack {
            Button {
                showTop5CoursesView = true
                topsViewModel.filterCoursesForProfession(selectedProfessionId: selectedProfessionId)
            } label: {
                CardView(content:
                            VStack(alignment: .leading) {
                    Text("🔎 Курсы")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color.theme.fontColorBW)
                        .opacity(0.9)
                }
                         , color: .accentColor)
                    .padding(.top, 5)
                    .frame(height: 130)
            }
        }
        .sheet(isPresented: $showTop5CoursesView, content: {
            Top5CoursesView(topsViewModel: topsViewModel)
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
        })
    }
}

struct Top5CoursesView: View {
    var topsViewModel: TopsViewModel
    
    var body: some View {
        ScrollView {
            Text("Top \(topsViewModel.filteredBooksForProfession.count) Courses")
                .bold()
                .padding()
                .padding(.top)
            
            ForEach(topsViewModel.filteredBooksForProfession, id: \.self) {course in
                CardView(content:
                            VStack {
                    // Name...
                    Text(course.name)
                        .font(.headline)
                        .foregroundStyle(.black)
                    
                    Text(course.autore)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }, color: .accentColor
                )
                .padding([.horizontal, .bottom])
                
            }
        }
        .task {
            try? await topsViewModel.getCoursesTops()
        }
    }
}
