import SwiftUI

struct Task: Identifiable {
    let id: UUID
    let title: String
    let isDone: Bool
}

struct TodolistItem: View {
    // -> Data
    let title: String
    let tasks: [Task]
    let deleteTask: (UUID) -> Void
    let changeFilter: (Filter) -> Void
    let createTask: (String) -> Void
    
    @State var newTaskText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                TextField("Placeholder", text: $newTaskText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                UniversalButton(title: "Add") {
                    print("Add")
                    guard !newTaskText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    createTask(newTaskText)
                    newTaskText = ""
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if tasks.isEmpty {
                    Text("Список пуст")
                }
                
                ForEach(tasks) { el in
                    HStack {
                        Image(el.isDone ? .yes : .stop)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(el.title)
                            .strikethrough(!el.isDone, color: .red)
                        Spacer()
                        UniversalButton(title: "Delete") {
                            print(el.id)
                            deleteTask(el.id)
                        }
                    }
                }
            }
            
            HStack(spacing: 16) {
                UniversalButton(title: Filter.all.rawValue) {
                    changeFilter(.all)
                }
                UniversalButton(title: Filter.active.rawValue) {
                    changeFilter(.active)
                }
                UniversalButton(title: Filter.completed.rawValue) {
                    changeFilter(.completed)
                }
                
                // --------------- или так ---------------------------------------
                //                ForEach(Filter.allCases, id: \.self) { filter in
                //                      UniversalButton(title: filter.rawValue) {
                //                          changeFilter(filter)
                //                      }
                //                  }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.yellow.opacity(0.3))
                            .drawingGroup()
                            .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        )
        .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        .padding()
    }
}
