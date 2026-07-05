import Foundation

struct TodolistTasksState {
    var todolists: [TodolistType]
    var tasks: TasksStateType
}


enum TodoAction {
    case createTodolist(title: String)
    case deleteTodolist(id: UUID)
    case changeTodolistTitle(id: UUID, title: String)
    case changeFilter(id: UUID, filter: FilterValuesType)
}


enum TasksAction {
    case createTask(todolistID: UUID, title: String)
    case deleteTask(todolistID: UUID, taskId: UUID)
    case changeTaskStatus(todolistID: UUID, taskId: UUID, isDone: Bool)
    case changeTaskTitle(todolistID: UUID, taskId: UUID, title: String)
}
