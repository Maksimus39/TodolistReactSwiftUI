import SwiftUI

struct AddListForm: View {
    @Environment(\.todoStore) private var store
    @State private var text = ""
    @State private var isError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(Constants.titleNewList, text: $text)
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
                
                Button(Constants.create) {
                    let trimmed = text.trimmingCharacters(in: .whitespaces)
                    if trimmed.isEmpty {
                        isError = true
                    } else {
                        isError = false
                        store?.dispatchTodoData(.createTodolist(title: trimmed))
                        text = ""
                    }
                }
                .padding(.trailing, 5)
                .buttonStyle(.borderedProminent)
                .opacity(text.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1.0)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
            
            if isError {
                Text(Constants.listTitle)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
    }
}
