import Observation



@Observable final class ContentViewModel {
    private(set) var state: TodolistTasksState
    
    init(initialState: TodolistTasksState = TodolistTasksState(todolists: [], tasks: [:])) {
        self.state = initialState
    }
    
    
    
    
    func dispatchTodoData(_ action: TodoAction) {
        state = todoReducer(state: state, action: action)
    }
    
    func dispatchTasksData(_ action: TasksAction) {
        state = tasksReducer(state: state, action: action)
    }
}




