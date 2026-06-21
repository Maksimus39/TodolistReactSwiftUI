import SwiftUI

struct EditableSpan: View {
    let text: String
    var isDone: Bool? = nil
    
    let onSave: (String) -> Void
    
    @State private var isEditing: Bool = false
    @State private var editingText: String = ""
    
    init(text: String, isDone: Bool? = nil, onSave: @escaping (String) -> Void) {
        self.text = text
        self.isDone = isDone
        self.onSave = onSave
    }
    
    var body: some View {
        Group {
            if isEditing {
                TextField("Название задачи", text: $editingText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 18))
                    .onSubmit { save() }
                    .onDisappear { save() }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.white)
                    .cornerRadius(8)
            } else {
                Text(text.isEmpty ? "Название задачи" : text)
                    .font(.system(size: 18))
                    .strikethrough(isDone == true, color: .gray)
                    .opacity(isDone == true ? 0.6 : 1.0)
                    .contentShape(Rectangle())
                    .accessibilityLabel(isDone == true ? "Выполнено: \(text)" : text)
                    .accessibilityHint("Дважды коснитесь для редактирования")
                    .onTapGesture(count: 2) {
                        editingText = text
                        isEditing = true
                    }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isEditing)
    }
    
    private func save() {
        let trimmed = editingText.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty && trimmed != text {
            onSave(trimmed)
        }
        isEditing = false
    }
}
