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
    let changeTasksStatus: (UUID, Bool) -> Void
    let filter: Filter
    
    @State var newTaskText: String = ""
    @State var error: Bool = false
    
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
                            .stroke(error ? .red : .gray, lineWidth: 1)
                    )
                    .onChange(of: newTaskText) { oldValue, newValue in
                        if error && !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            error = false
                        }
                    }
                UniversalButton(title: "Add") {
                    print("Add")
                    if newTaskText.trimmingCharacters(in: .whitespaces).isEmpty {
                        error = true
                    } else {
                        error = false
                        createTask(newTaskText)
                        newTaskText = ""
                    }
                }
            }
            
            if error {
                Text("⚠️ Пожалуйста, заполните поле")
                    .foregroundColor(.red)
                    .font(.system(size: 18))
                    .font(.caption)
                    .padding(.leading, 4)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if tasks.isEmpty {
                    Text("Список пуст")
                }
                
                ForEach(tasks) { el in
                    HStack(spacing: 20) {
                        Image(el.isDone ? .yes : .stop)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                changeTasksStatus(el.id, !el.isDone)
                            }
                        
                        Text(el.title)
                            .font(.system(size: 18))
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
                UniversalButton(
                    title: Filter.all.rawValue,
                    onClickHandler: { changeFilter(.all) },
                    isActive: filter == .all
                )
                UniversalButton(
                    title: Filter.active.rawValue,
                    onClickHandler: { changeFilter(.active) },
                    isActive: filter == .active
                )
                UniversalButton(
                    title: Filter.completed.rawValue,
                    onClickHandler: { changeFilter(.completed) },
                    isActive: filter == .completed
                )
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
