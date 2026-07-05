import Foundation



func tasksReducer(state: TodolistTasksState, action: TasksAction) -> TodolistTasksState {
    var newState = state
    
    switch action {
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

