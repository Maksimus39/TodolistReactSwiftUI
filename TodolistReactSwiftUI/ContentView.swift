import SwiftUI

enum Filter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

struct ContentView: View {
    // Data
    let todolistIOSTitle:String = "IOS developer"
    
    @State var tasksIOS: [Task] = [
        Task(id: UUID(), title: "Swift", isDone: true),
        Task(id: UUID(), title: "UIKit", isDone: true),
        Task(id: UUID(), title: "SwiftUI", isDone: true),
        Task(id: UUID(), title: "URLSession", isDone: true),
        Task(id: UUID(), title: "Alamofire", isDone: true),
        Task(id: UUID(), title: "CoreData", isDone: false),
        Task(id: UUID(), title: "SwiftData", isDone: false),
        Task(id: UUID(), title: "Firebase", isDone: false),
        Task(id: UUID(), title: "GCD", isDone: false),
        Task(id: UUID(), title: "Combine", isDone: false),
        Task(id: UUID(), title: "Viper", isDone: false),
        Task(id: UUID(), title: "Clean Architecture", isDone: false),
        Task(id: UUID(), title: "MVP", isDone: true),
        Task(id: UUID(), title: "MVVM", isDone: true),
        Task(id: UUID(), title: "HitTest. UIResponderChain", isDone: false),
        Task(id: UUID(), title: "Unit Tests", isDone: false),
        Task(id: UUID(), title: "diffibleDataSource", isDone: false),
        Task(id: UUID(), title: "SdWebImage", isDone: true),
        Task(id: UUID(), title: "Я изучаю IOS Dev)))", isDone: true),
    ]
    @State var filter: Filter = .all
    
    // Delete tasks
    func deleteTask (deleteTask: UUID) {
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
    
    // Create task
    func createTask (taskTitle: String) {
        tasksIOS.insert(Task(id: UUID(), title: taskTitle, isDone: false), at: 0)
    }
    
    // Update tasks
    func changeTasksStatus(taskID: UUID, newStatus: Bool) {
        tasksIOS = tasksIOS.map { $0.id == taskID ? Task(id: $0.id, title: $0.title, isDone: newStatus) : $0 }
    }
    
    
    // UI
    var body: some View {
        ScrollView {
            LazyVStack {
                TodolistItem(
                    title: todolistIOSTitle,
                    tasks: filteredTasks,
                    deleteTask: deleteTask,
                    changeFilter: changeFilter,
                    createTask: createTask,
                    changeTasksStatus: changeTasksStatus,
                    filter: filter,
                )
            }
        }
        .background(.mint.opacity(0.2))
    }
}

#Preview {
    ContentView()
}
