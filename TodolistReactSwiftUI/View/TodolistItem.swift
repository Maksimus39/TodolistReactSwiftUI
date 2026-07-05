import SwiftUI

struct TodolistItem: View {
    @Environment(\.todoStore) private var store
    
    let list: TodolistType
    
    init(list: TodolistType) {
        self.list = list
    }
    
    private var filteredTasks: [TaskItem] {
        let tasks = store?.state.tasks[list.id] ?? []
        switch list.filter {
        case .all: return tasks
        case .active: return tasks.filter { !$0.isDone }
        case .completed: return tasks.filter { $0.isDone }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                EditableSpan(
                    text: list.title,
                    onSave: { newValue in
                        store?.dispatchTodoData(.changeTodolistTitle(id: list.id, title: newValue))
                    }
                )
                .font(.title3)
                .fontWeight(.bold)
                
                Spacer()
                
                Menu {
                    Button(role: .destructive) {
                        store?.dispatchTodoData(.deleteTodolist(id: list.id))
                    } label: {
                        Label(Constants.deleteList, systemImage: Constants.trasch)
                    }
                } label: {
                    Image(systemName: Constants.ellipsisCircle)
                        .foregroundColor(.secondary)
                        .font(.title3)
                }
            }
            
            Picker(Constants.filter, selection: Binding(
                get: { list.filter },
                set: { store?.dispatchTodoData(.changeFilter(id: list.id, filter: $0)) }
            )) {
                ForEach(FilterValuesType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            
            AddItemForm(todolistID: list.id)
            
            List {
                if filteredTasks.isEmpty {
                    Text(Constants.notTasks)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                }
                
                ForEach(filteredTasks) { task in
                    TaskRow(task: task, todolistID: list.id)
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
