import Foundation


struct AppTodolistState {
    var todolists: [TodolistType]
    var tasks: TasksStateType
}


enum TodoAction {
    // Todolists
    case createTodolist(title: String)
    case deleteTodolist(id: UUID)
    case changeTodolistTitle(id: UUID, title: String)
    case changeFilter(id: UUID, filter: FilterValuesType)
    
    // Tasks
    case createTask(todolistID: UUID, title: String)
    case deleteTask(todolistID: UUID, taskId: UUID)
    case changeTaskStatus(todolistID: UUID, taskId: UUID, isDone: Bool)
    case changeTaskTitle(todolistID: UUID, taskId: UUID, title: String)
}



func todoAndTasksDataReducer(state: AppTodolistState, action: TodoAction) -> AppTodolistState {
    var newState = state
    
    switch action {
    case .createTodolist(let title):
        let newList = TodolistType(id: UUID(), title: title, filter: .all)
        newState.todolists.insert(newList, at: 0)
        newState.tasks[newList.id] = []
        
    case .deleteTodolist(let id):
        newState.todolists.removeAll { $0.id == id }
        newState.tasks[id] = nil
        
        
    case .changeTodolistTitle(let id, let title):
        if let index = newState.todolists.firstIndex(where: { $0.id == id }) {
            newState.todolists[index].title = title
        }
        
    case .changeFilter(let id, let filter):
        if let index = newState.todolists.firstIndex(where: { $0.id == id }) {
            newState.todolists[index].filter = filter
        }
        
    case .createTask(let todolistID, let title):
        let newTask = TaskItem(id: UUID(), title: title, isDone: false)
        newState.tasks[todolistID] = [newTask] + (newState.tasks[todolistID] ?? [])
        
    case .deleteTask(let todolistID, let taskId):
        newState.tasks[todolistID] = newState.tasks[todolistID]?.filter { $0.id != taskId }
        
    case .changeTaskStatus(let todolistID, let taskId, let isDone):
        newState.tasks[todolistID] = newState.tasks[todolistID]?.map {$0.id == taskId ? TaskItem(id: $0.id, title: $0.title, isDone: isDone) : $0}
        
    case .changeTaskTitle(let todolistID, let taskId, let title):
        newState.tasks[todolistID] = newState.tasks[todolistID]?.map {$0.id == taskId ? TaskItem(id: $0.id, title: title, isDone: $0.isDone) : $0}
        
    }
    
    return newState
}


