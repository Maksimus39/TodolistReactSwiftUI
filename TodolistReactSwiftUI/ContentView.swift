import SwiftUI

struct ContentView: View {
    // Data
    let todolistIOSTitle: String = "IOS developer"
    let todolistReactTitle: String = "React developer"
    // --------------------
    let tasksIOS = [
        Task(id: 1, title: "Swift", isDone: true),
        Task(id: 2, title: "UIKit", isDone: true),
        Task(id: 3, title: "SwiftUI", isDone: true),
        Task(id: 4, title: "URLSession", isDone: false),
        Task(id: 5, title: "Alamofire", isDone: false),
        Task(id: 6, title: "CoreData", isDone: false),
        Task(id: 7, title: "SwiftData", isDone: false),
        Task(id: 8, title: "Firebase", isDone: false),
    ]
    let tasksReact = [
        Task(id: 1, title: "JavaScript", isDone: true),
        Task(id: 2, title: "TypeScript", isDone: true),
        Task(id: 3, title: "React", isDone: true),
        Task(id: 4, title: "Redux", isDone: false),
        Task(id: 5, title: "axios", isDone: false),
        Task(id: 6, title: "React routing", isDone: false),
        Task(id: 7, title: "Rtk2.0", isDone: false),
        Task(id: 8, title: "CSS", isDone: false),
    ]
        
    // UI
    var body: some View {
        ScrollView {
            VStack {
                TodolistItem(title: todolistIOSTitle, tasks: tasksIOS)
                TodolistItem(title: todolistReactTitle, tasks: tasksReact)
            }
        }
        .background(.mint.opacity(0.2))
    }
}

#Preview {
    ContentView()
}
