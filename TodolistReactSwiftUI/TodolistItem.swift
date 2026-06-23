import SwiftUI

struct TodolistItem: View {
    let id: UUID
    @Binding var title: String
    @Binding var filter: FilterValuesType
    
    @Binding var allTasks: TasksStateType
    let listId: UUID
    
    let deleteTodolist: (UUID) -> Void
    let changeTaskTitle: (UUID, String, UUID) -> Void
    let changeTasksStatus: (UUID, Bool, UUID) -> Void
    let deleteTask: (UUID, UUID) -> Void
    let createTask: (String, UUID) -> Void
    
    private var filteredTasks: [TaskItem] {
        let tasks = allTasks[listId] ?? []
        switch filter {
        case .all: return tasks
        case .active: return tasks.filter { !$0.isDone }
        case .completed: return tasks.filter { $0.isDone }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                EditableSpan(text: title, onSave: { title = $0 })
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Menu {
                    Button(role: .destructive) { deleteTodolist(id) } label: {
                        Label("Удалить список", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.secondary)
                        .font(.title3)
                }
            }
            
            Picker("Фильтр", selection: $filter) {
                ForEach(FilterValuesType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            AddItemForm(createTask: { createTask($0, listId) })
            List {
                if filteredTasks.isEmpty {
                    Text("Нет задач")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                }
                
                ForEach(filteredTasks) { task in
                    TaskRow(
                        task: task,
                        onToggle: { changeTasksStatus(task.id, !task.isDone, listId) },
                        onSaveTitle: { changeTaskTitle(task.id, $0, listId) },
                        onDelete: { deleteTask(task.id, listId) }
                    )
                    .listRowSeparator(.visible)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollDisabled(true)
            .frame(height: CGFloat(filteredTasks.count) * 56 + (filteredTasks.isEmpty ? 40 : 0))
            .padding(.top, 4)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}


struct TaskRow: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onSaveTitle: (String) -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(task.isDone ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)
            
            EditableSpan(text: task.title, isDone: task.isDone, onSave: onSaveTitle)
                .font(.body)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Удалить", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}
