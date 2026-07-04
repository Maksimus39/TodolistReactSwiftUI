import SwiftUI


struct EditableSpan: View {
    let text: String
    var isDone: Bool? = nil
    let onSave: (String) -> Void
    
    @State private var isEditing = false
    @State private var editingText = ""
    
    var body: some View {
        Group {
            if isEditing {
                TextField(Constants.change, text: $editingText)
                    .onSubmit { save() }
                    .onDisappear { save() }
            } else {
                Text(text.isEmpty ? Constants.untitled : text)
                    .strikethrough(isDone == true, color: .secondary)
                    .opacity(isDone == true ? 0.6 : 1.0)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        editingText = text
                        isEditing = true
                    }
            }
        }
        .animation(.easeInOut, value: isEditing)
    }
    
    private func save() {
        let trimmed = editingText.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty && trimmed != text {
            onSave(trimmed)
        }
        isEditing = false
    }
}
