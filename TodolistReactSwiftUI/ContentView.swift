import SwiftUI

enum FilterValuesType: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

struct TaskItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let isDone: Bool
}

struct TodolistType: Identifiable {
    let id: UUID
    let title: String
    var filter: FilterValuesType 
}

typealias TasksStateType = [UUID: [TaskItem]]

struct ContentView: View {
    static let iosId = UUID()
    static let reactId = UUID()
    
    @State var todolists: [TodolistType] = [
        TodolistType(id: Self.iosId, title: "IOS developer", filter: .active),
        TodolistType(id: Self.reactId, title: "React developer", filter: .active),
    ]
    
    @State var tasks: TasksStateType = [
        Self.iosId: [
            TaskItem(id: UUID(), title: "Swift", isDone: true),
            TaskItem(id: UUID(), title: "UIKit", isDone: true),
            TaskItem(id: UUID(), title: "SwiftUI", isDone: true),
            TaskItem(id: UUID(), title: "URLSession", isDone: true),
            TaskItem(id: UUID(), title: "Alamofire", isDone: true),
            TaskItem(id: UUID(), title: "CoreData", isDone: false),
            TaskItem(id: UUID(), title: "SwiftData", isDone: false),
            TaskItem(id: UUID(), title: "Firebase", isDone: false),
            TaskItem(id: UUID(), title: "GCD", isDone: false),
            TaskItem(id: UUID(), title: "Combine", isDone: false),
            TaskItem(id: UUID(), title: "Viper", isDone: false),
            TaskItem(id: UUID(), title: "Clean Architecture", isDone: false),
            TaskItem(id: UUID(), title: "MVP", isDone: true),
            TaskItem(id: UUID(), title: "MVVM", isDone: true),
            TaskItem(id: UUID(), title: "HitTest. UIResponderChain", isDone: false),
            TaskItem(id: UUID(), title: "Unit Tests", isDone: false),
            TaskItem(id: UUID(), title: "diffibleDataSource", isDone: false),
            TaskItem(id: UUID(), title: "SdWebImage", isDone: true),
            TaskItem(id: UUID(), title: "Я изучаю IOS Dev)))", isDone: true),
        ],
        Self.reactId: [
            TaskItem(id: UUID(), title: "JavaScript", isDone: true),
            TaskItem(id: UUID(), title: "TypeScript", isDone: true),
            TaskItem(id: UUID(), title: "React", isDone: true),
            TaskItem(id: UUID(), title: "Redux", isDone: true),
            TaskItem(id: UUID(), title: "HTML", isDone: true),
            TaskItem(id: UUID(), title: "CSS", isDone: true),
            TaskItem(id: UUID(), title: "Redux Toolkit", isDone: true),
            TaskItem(id: UUID(), title: "RTK 2.0", isDone: true),
            TaskItem(id: UUID(), title: "Styled Components", isDone: true),
            TaskItem(id: UUID(), title: "Tailwind", isDone: false),
            TaskItem(id: UUID(), title: "axios", isDone: true),
            TaskItem(id: UUID(), title: "React routing dom", isDone: true),
            TaskItem(id: UUID(), title: "Computer science", isDone: false),
            TaskItem(id: UUID(), title: "CI/CD", isDone: false),
            TaskItem(id: UUID(), title: "Docker", isDone: true),
            TaskItem(id: UUID(), title: "Next.js", isDone: false),
            TaskItem(id: UUID(), title: "Storybook", isDone: true),
            TaskItem(id: UUID(), title: "GraphQL", isDone: false),
            TaskItem(id: UUID(), title: "OAuth2", isDone: false),
            TaskItem(id: UUID(), title: "Tanstack Query + FSD", isDone: false),
            TaskItem(id: UUID(), title: "kubernetes", isDone: false),
            TaskItem(id: UUID(), title: "Recaptcha", isDone: true),
        ]
    ]
    

    func getFilteredTasks(todolist: TodolistType) -> [TaskItem] {
        let allTasks = tasks[todolist.id] ?? []
        
        switch todolist.filter {
        case .all:
            return allTasks
        case .active:
            return allTasks.filter { !$0.isDone }
        case .completed:
            return allTasks.filter { $0.isDone }
        }
    }
    
    // Delete task
    func deleteTask(deleteTask: UUID, todolistID: UUID) {
        tasks[todolistID] = tasks[todolistID]?.filter { $0.id != deleteTask }
    }
    
    // Change filter
    func changeFilter(filterTasks: FilterValuesType, todolistID: UUID) {
        todolists = todolists.map { $0.id == todolistID ? TodolistType(id: $0.id, title: $0.title, filter: filterTasks) : $0 }
    }
    
    // Create task
    func createTask(taskTitle: String, todolistID: UUID) {
        let newTask = TaskItem(id: UUID(), title: taskTitle, isDone: false)
        tasks[todolistID] = [newTask] + (tasks[todolistID] ?? [])
    }
    
    // Change task status
    func changeTasksStatus(taskID: UUID, newStatus: Bool, todolistID: UUID) {
        tasks[todolistID] = tasks[todolistID]?.map { $0.id == taskID ? TaskItem(id: $0.id, title: $0.title, isDone: newStatus) : $0 }
    }
    
    // Delete todolist
    func deleteTodolist(todolistID: UUID) {
        todolists = todolists.filter { $0.id != todolistID }
        tasks[todolistID] = nil
    }
        
    
    
    var body: some View {
           ScrollView {
               LazyVStack(spacing: 20) {
                   ForEach(todolists) {
                       TodolistItem(
                           id: $0.id,
                           title: $0.title,
                           filter: $0.filter,
                           tasks: getFilteredTasks(todolist: $0),
                           deleteTask: deleteTask,
                           changeFilter: changeFilter,
                           createTask: createTask,
                           changeTasksStatus: changeTasksStatus,
                           deleteTodolist: deleteTodolist,
                       )
                   }
               }
               .padding()
           }
           .background(.mint.opacity(0.2))
       }
}

#Preview {
    ContentView()
}
