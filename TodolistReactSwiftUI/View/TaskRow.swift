import SwiftUI

struct TaskRow: View {
    let task: TaskItem
    let todolistID: UUID
    
    @Environment(\.todoStore) private var store 
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                store?.dispatchTasksData(.changeTaskStatus(
                    todolistID: todolistID,
                    taskId: task.id,
                    isDone: !task.isDone
                ))
            } label: {
                Image(systemName: task.isDone ? Constants.checkmarkCircleFill : Constants.circle)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(task.isDone ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            
            EditableSpan(
                text: task.title,
                isDone: task.isDone,
                onSave: { newTitle in
                    store?.dispatchTasksData(.changeTaskTitle(
                        todolistID: todolistID,
                        taskId: task.id,
                        title: newTitle
                    ))
                }
            )
            .font(.body)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                store?.dispatchTasksData(.deleteTask(
                    todolistID: todolistID,
                    taskId: task.id
                ))
            } label: {
                Label(Constants.delete, systemImage: Constants.trash)
            }
            .tint(.red)
        }
    }
}
