import SwiftUI

struct TodolistItem: View {
     let id: UUID
     let title: String
     let filter: FilterValuesType
     let tasks: [TaskItem]
     let deleteTask: (UUID, UUID) -> Void
     let changeFilter: (FilterValuesType, UUID) -> Void
     let createTask: (String, UUID) -> Void
     let changeTasksStatus: (UUID, Bool, UUID) -> Void
     let deleteTodolist: (UUID) -> Void
     let changeTaskTitle: (UUID, String, UUID) -> Void
     let changeTodolistTitle: (String, UUID) -> Void
    
    
    private func handleTaskTitleChange(taskId: UUID, newTitle: String) {
        changeTaskTitle(taskId, newTitle, id)
    }
    
    private func createTaskCallback(newTaskTitle: String) {
        createTask(newTaskTitle, id)
    }
    
    private func changeTodolistTitleCallback(newTitle: String) {
        changeTodolistTitle(newTitle, id)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 20) {
                EditableSpan(text: title, onSave: changeTodolistTitleCallback)
                Spacer()
                UniversalButton(title: "Delete") {
                    deleteTodolist(id)
                }
            }
            
            AddItemForm(createTask: createTaskCallback)
            
            VStack(alignment: .leading, spacing: 8) {
                if tasks.isEmpty {
                    Text("Список пуст")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                }
                
                ForEach(tasks) { task in
                    HStack(spacing: 20) {
                        Image(task.isDone ? .yes : .stop)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                changeTasksStatus(task.id, !task.isDone, id)
                            }
                        
                        EditableSpan(
                            text: task.title,
                            isDone: task.isDone,
                            onSave: { newTitle in
                                handleTaskTitleChange(taskId: task.id, newTitle: newTitle)
                            }
                        )
                        .id(task.id)
                        
                        Spacer()
                        
                        UniversalButton(title: "Delete") {
                            deleteTask(task.id, id)
                        }
                    }
                }
            }
            
            HStack(spacing: 16) {
                ForEach(FilterValuesType.allCases, id: \.self) { filterType in
                    UniversalButton(
                        title: filterType.rawValue,
                        onClickHandler: { changeFilter(filterType, id) },
                        isActive: filter == filterType
                    )
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.yellow.opacity(0.3))
                .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        )
        .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        .padding()
    }
}
