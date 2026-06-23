import SwiftUI

struct ContentView: View {
    static let iosId = UUID()
    static let reactId = UUID()
    
    @State var todolists: [TodolistType] = [
        TodolistType(id: Self.iosId, title: "iOS Development", filter: .all),
        TodolistType(id: Self.reactId, title: "React Learning", filter: .all),
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
    
    private func getFilteredTasks(todolist: TodolistType) -> [TaskItem] {
        let allTasks = tasks[todolist.id] ?? []
        switch todolist.filter {
        case .all: return allTasks
        case .active: return allTasks.filter { !$0.isDone }
        case .completed: return allTasks.filter { $0.isDone }
        }
    }
    
    private func deleteTask(taskId: UUID, todolistID: UUID) {
        tasks[todolistID] = tasks[todolistID]?.filter { $0.id != taskId }
    }
    
    private func changeFilter(filter: FilterValuesType, todolistID: UUID) {
        if let index = todolists.firstIndex(where: { $0.id == todolistID }) {
            todolists[index].filter = filter
        }
    }
    
    private func createTask(title: String, todolistID: UUID) {
        let newTask = TaskItem(id: UUID(), title: title, isDone: false)
        tasks[todolistID] = [newTask] + (tasks[todolistID] ?? [])
    }
    
    private func changeTasksStatus(taskID: UUID, newStatus: Bool, todolistID: UUID) {
        tasks[todolistID] = tasks[todolistID]?.map {
            $0.id == taskID ? TaskItem(id: $0.id, title: $0.title, isDone: newStatus) : $0
        }
    }
    
    private func deleteTodolist(todolistID: UUID) {
        todolists.removeAll { $0.id == todolistID }
        tasks[todolistID] = nil
    }
    
    private func createTodolist(title: String) {
        let newList = TodolistType(id: UUID(), title: title, filter: .all)
        todolists.insert(newList, at: 0)
        tasks[newList.id] = []
    }
    
    private func changeTaskTitle(taskID: UUID, newTitle: String, todolistID: UUID) {
        tasks[todolistID] = tasks[todolistID]?.map {
            $0.id == taskID ? TaskItem(id: $0.id, title: newTitle, isDone: $0.isDone) : $0
        }
    }
    
    private func changeTodolistTitle(title: String, todolistID: UUID) {
        if let index = todolists.firstIndex(where: { $0.id == todolistID }) {
            todolists[index].title = title
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    AddListForm(createList: createTodolist)
                        .padding(.horizontal)
                    
                    ForEach($todolists) { $list in
                        TodolistItem(
                            id: list.id,
                            title: $list.title,
                            filter: $list.filter,
                            allTasks: $tasks,
                            listId: list.id,
                            deleteTodolist: deleteTodolist,
                            changeTaskTitle: changeTaskTitle,
                            changeTasksStatus: changeTasksStatus,
                            deleteTask: deleteTask,
                            createTask: createTask
                        )
                    }
                }
                .padding(.vertical)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Мои Проекты")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
