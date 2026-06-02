import SwiftUI

enum Filter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

struct ContentView: View {
    // Data
    let todolistIOSTitle: String = "IOS developer"
    
    @State var tasksIOS = [
        Task(id: 1, title: "Swift", isDone: true),
        Task(id: 2, title: "UIKit", isDone: true),
        Task(id: 3, title: "SwiftUI", isDone: true),
        Task(id: 4, title: "URLSession", isDone: true),
        Task(id: 5, title: "Alamofire", isDone: true),
        Task(id: 6, title: "CoreData", isDone: false),
        Task(id: 7, title: "SwiftData", isDone: false),
        Task(id: 8, title: "Firebase", isDone: false),
        Task(id: 9, title: "GCD", isDone: false),
        Task(id: 10, title: "Combine", isDone: false),
        Task(id: 11, title: "Viper", isDone: false),
        Task(id: 12, title: "Clean Architecture", isDone: false),
        Task(id: 13, title: "MVP", isDone: true),
        Task(id: 14, title: "MVVM", isDone: true),
        Task(id: 15, title: "HitTest. UIResponderChain", isDone: false),
        Task(id: 16, title: "Unit Tests", isDone: false),
        Task(id: 17, title: "diffibleDataSource", isDone: false),
        Task(id: 18, title: "SdWebImage", isDone: true),
        Task(id: 19, title: "В общем я хочу осваивать IOS Dev)))", isDone: true),
    ]
    @State var filter: Filter = .all

    // Delete tasks
    func deleteTask (deleteTask: Int) {
        tasksIOS = tasksIOS.filter { $0.id != deleteTask }
    }
    
    // Filter tasks
    var filteredTasks: [Task] {
        switch filter {
        case .all:
            tasksIOS
        case .active:
            tasksIOS.filter { !$0.isDone }
        case .completed:
            tasksIOS.filter { $0.isDone }
        }
    }
    
    func changeFilter (to filterTasks: Filter) {
        filter = filterTasks
    }
    
    // UI
    var body: some View {
        ScrollView {
            VStack {
                TodolistItem(title: todolistIOSTitle,
                             tasks: filteredTasks,
                             deleteTask: deleteTask,
                             changeFilter: changeFilter
                )
            }
        }
        .background(.mint.opacity(0.2))
    }
}

#Preview {
    ContentView()
}
