import SwiftUI

struct AddItemForm: View {
    let createTask: (String) -> Void
    
    @State private var newTaskText: String = ""
    @State private var error: Bool = false
    
    var body: some View {
        HStack {
            TextField("Новая задача", text: $newTaskText)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(error ? .red : .gray, lineWidth: 1)
                )
                .onChange(of: newTaskText) { _, newValue in
                    if error && !newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                        error = false
                    }
                }
            
            UniversalButton(title: "Add") {
                let trimmed = newTaskText.trimmingCharacters(in: .whitespaces)
                if trimmed.isEmpty {
                    error = true
                } else {
                    error = false
                    createTask(trimmed)
                    newTaskText = ""
                }
            }
        }
        
        if error {
            Text("⚠️ Пожалуйста, заполните поле")
                .foregroundColor(.red)
                .font(.caption)
                .padding(.leading, 4)
        }
    }
}
