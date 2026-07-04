import SwiftUI

@main
struct TodolistReactSwiftUIApp: App {
    
    @State private var todoAndTaskViewModel = ContentViewModel(
    initialState: AppTodolistState(
            todolists: [],
            tasks: [:]
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: todoAndTaskViewModel)
        }
    }
}
