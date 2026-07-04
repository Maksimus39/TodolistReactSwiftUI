import SwiftUI

struct ContentView: View {
    @Bindable var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    AddListForm { title in
                        viewModel.dispatchData(.createTodolist(title: title))
                    }
                    .padding(.horizontal)
                    
                    ForEach(viewModel.state.todolists) { list in
                        TodolistItem(
                            id: list.id,
                            title: Binding(
                                get: { list.title },
                                set: { viewModel.dispatchData(.changeTodolistTitle(id: list.id, title: $0)) }
                            ),
                            filter: Binding(
                                get: { list.filter },
                                set: { viewModel.dispatchData(.changeFilter(id: list.id, filter: $0)) }
                            ),
                            
                            allTasks: viewModel.state.tasks[list.id] ?? [],
                            listId: list.id,
                            deleteTodolist: { viewModel.dispatchData(.deleteTodolist(id: $0)) },
                            changeTaskTitle: { viewModel.dispatchData(.changeTaskTitle(todolistID: $2, taskId: $0, title: $1)) },
                            changeTasksStatus: { viewModel.dispatchData(.changeTaskStatus(todolistID: $2, taskId: $0, isDone: $1)) },
                            deleteTask: { viewModel.dispatchData(.deleteTask(todolistID: $1, taskId: $0)) },
                            createTask: { viewModel.dispatchData(.createTask(todolistID: $1, title: $0)) }
                        )
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color(.systemGroupedBackground))
        .navigationTitle(Constants.myProject)
        .navigationBarTitleDisplayMode(.large)
    }
}
