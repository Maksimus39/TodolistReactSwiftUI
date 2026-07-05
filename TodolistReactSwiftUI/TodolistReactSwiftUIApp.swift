import SwiftUI

@main
struct TodolistReactSwiftUIApp: App {
    @State private var viewModel = ContentViewModel(
        initialState: TodolistTasksState(todolists: [], tasks: [:])
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .provideTodoStore(viewModel)
        }
    }
}
