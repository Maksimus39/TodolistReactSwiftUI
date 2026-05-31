import SwiftUI

struct Task: Identifiable {
    let id: Int
    let title: String
    let isDone: Bool
}

struct TodolistItem: View {
    // -> Data
    let title: String
    private var tasks: [Task]
    
    init(title: String, tasks: [Task]) {
        self.title = title
        self.tasks = tasks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                TextField("", text: .constant(""))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                UniversalButton(title: "Add")
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if tasks.isEmpty {
                    Text("Список пуст")
                }
                
                ForEach(tasks) { el in
                    HStack {
                        Image(systemName: el.isDone ? "checkmark.square" : "square")
                        Text(el.title)
                    }
                }
            }
            
            HStack(spacing: 16) {
                UniversalButton(title: "All")
                UniversalButton(title: "Active")
                UniversalButton(title: "Completed")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.yellow.opacity(0.3))
        )
        .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        .padding()
    }
}
