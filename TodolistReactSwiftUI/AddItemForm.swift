import SwiftUI

enum FilterValuesType: String, CaseIterable {
    case all = "Все"
    case active = "Активные"
    case completed = "Готовые"
}

struct TaskItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let isDone: Bool
}

struct TodolistType: Identifiable {
    let id: UUID
    var title: String
    var filter: FilterValuesType
}

typealias TasksStateType = [UUID: [TaskItem]]


struct AddItemForm: View {
    let createTask: (String) -> Void
    @State private var text = ""
    @State private var isError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                TextField("Новая задача", text: $text)
                    .textFieldStyle(.plain)
                    .padding(10)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isError ? .red : .clear, lineWidth: 2)
                    )
                    .onChange(of: text) { _, newValue in
                        if isError && !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            isError = false
                        }
                    }
                
                Button(action: {
                    let trimmed = text.trimmingCharacters(in: .whitespaces)
                    if trimmed.isEmpty {
                        isError = true
                    } else {
                        isError = false
                        createTask(trimmed)
                        text = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(text.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
                }
            }
            
            if isError {
                Text("⚠️ Название задачи не может быть пустым")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
                    .transition(.opacity)
            }
        }
    }
}


struct AddListForm: View {
    let createList: (String) -> Void
    @State private var text = ""
    @State private var isError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField("Название нового списка", text: $text)
                    .textFieldStyle(.plain)
                    .padding(10)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isError ? Color.red : Color.clear, lineWidth: 2)
                    )
                    .onChange(of: text) { _, newValue in
                        if isError && !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                            isError = false
                        }
                    }
                
                Button("Создать") {
                    let trimmed = text.trimmingCharacters(in: .whitespaces)
                    if trimmed.isEmpty {
                        isError = true
                    } else {
                        isError = false
                        createList(trimmed)
                        text = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .opacity(text.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1.0)
            }
            
            if isError {
                Text("⚠️ У списка должно быть название")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
    }
}


