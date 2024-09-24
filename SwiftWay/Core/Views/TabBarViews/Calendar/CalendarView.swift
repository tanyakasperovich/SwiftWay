//
//  CalendarView.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI
 
// Date Value Model...
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

struct CalendarView: View {
    @State var currentDate: Date = Date()
    @EnvironmentObject var roadMapViewModel: RoadMapViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // Custom Date Picker...
            CustomDatePicker(currentDate: $currentDate)
        }
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
//        .background(BackgroundView(color: .accentColor, image: roadMapViewModel.selectedProfession?.image ?? ""))
    }
}

#Preview {
    CalendarView()
        .environmentObject(RoadMapViewModel())
        .environmentObject(ProfileViewModel())
}

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    
    //  @State private var newTask = ""
    @State private var date = Date()
    
    @StateObject private var taskViewModel = TaskViewModel()

    var body: some View {
        VStack(spacing: 20) {
            
            // Days...
            let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            // Month View...
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    
                    HStack(spacing: 30) {
                        Button {
                            
                        } label: {
                            PBView(content: Text(extraDate()[1]).padding(7), color: .accentColor, isSet: .constant(true))
                        }
                        
                    Spacer(minLength: 0)
                        
                    HStack {
                            Button {
                                withAnimation{
                                    currentMonth -= 1
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(Color.accentColor)
                                    .padding(.horizontal)
                            }
                        
                            
                            Button {
                                withAnimation{
                                    currentMonth += 1
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .foregroundColor(Color.accentColor)
                                    .padding(.leading)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            
            // Day View...
            HStack(spacing: 0){
                ForEach(days,id: \.self){day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.accentColor)
                }
            }
            
            // Dates...
            // Lazy Grid...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 5) {
                
                ForEach(extractDate()){value in
                    
                    CardView(value: value)
                        .background(
                            RoundedRectangleShape(color: .accentColor)
                                .padding(.horizontal, 3)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1: 0)
                                .shadow(color: Color.black, radius: 2, x: 1, y: -1)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangleShape(color: .accentColor)
                    .opacity(0.2)
            )
            
            // Tasks...
//            TasksView(currentDate: $currentDate)

            VStack {
                HStack {
                    Text("Tasks")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                }
                
                TasksListView(viewModel: taskViewModel, currentDate: $currentDate)
            }
        }
        .onChange(of: currentMonth) { newValue in
            // updating Month...
            currentDate = getCurrentMonth()
        }
        .task {
            await taskViewModel.getUserTasks()
        }
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack {
            if value.day != -1{
//                            Text("\(value.day)")
//                                .font(.title3.bold())

                if let task = taskViewModel.userTasks.first(where: { task in
                    return isSameDay(date1: task.time, date2: value.date)}){

                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.time , date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    HStack {
                       // if task.educationTask ?? false {
                            Circle()
                                .fill(isSameDay(date1: task.time , date2: currentDate) ? Color.white.opacity(0.8) : Color.theme.darkPinkColor)
                            //.fill(Color.theme.darkPinkColor)
                                .frame(width: 8, height: 8)
                      //  }
                        
                       // if !(task.educationTask ?? false) {
                            Circle()
                            // .fill(Color.theme.iceColor)
                                .fill(isSameDay(date1: task.time , date2: currentDate) ? Color.white.opacity(0.6) : .theme.iceColor)
                                .frame(width: 8, height: 8)
                      //  }
                    }
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //extrating Year And Month for display...
    func extraDate()->[String]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

// Extending Date to get Current Month Dates...
extension Date{
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        // getting date...
        return range.compactMap{ day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

// MARK: - CalendarDatePicker
struct CalendarDatePickerView: View {
    @State private var date = Date()
    
    var body: some View {
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}
