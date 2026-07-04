import Observation


@Observable final class ContentViewModel {
    private(set) var state: AppTodolistState
    
    init(initialState: AppTodolistState = AppTodolistState(todolists: [], tasks: [:])) {
        self.state = initialState
    }
    
    
    func dispatchData(_ action: TodoAction) {
        state = todoAndTasksDataReducer(state: state, action: action)
    }
}



