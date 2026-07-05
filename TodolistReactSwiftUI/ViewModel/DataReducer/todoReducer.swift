import Foundation


func todoReducer(state: TodolistTasksState, action: TodoAction) -> TodolistTasksState {
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
    }
    
    
    return newState
}
