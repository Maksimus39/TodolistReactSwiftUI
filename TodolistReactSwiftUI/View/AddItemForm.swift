import SwiftUI

struct AddItemForm: View {
    @Environment(\.todoStore) private var store
    
    let todolistID: UUID
    @State private var text = ""
    @State private var isError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                TextField(Constants.newTasks, text: $text)
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
                        store?.dispatchTasksData(.createTask(todolistID: todolistID, title: trimmed))
                        text = ""
                    }
                }) {
                    Image(systemName: Constants.plusCircleFill)
                        .font(.title2)
                        .foregroundStyle(text.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .blue)
                }
            }
            
            if isError {
                Text(Constants.taskNameBeEmpty)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
                    .transition(.opacity)
            }
        }
    }
}
