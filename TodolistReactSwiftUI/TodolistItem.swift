import SwiftUI


struct TodolistItem: View {
    // -> Data
    let id: UUID
    let title: String
    let filter: FilterValuesType
    let tasks: [TaskItem]
    let deleteTask: (UUID, UUID) -> Void
    let changeFilter: (FilterValuesType, UUID) -> Void
    let createTask: (String, UUID) -> Void
    let changeTasksStatus: (UUID, Bool, UUID) -> Void
    let deleteTodolist: (UUID) -> Void
    
    @State var newTaskText: String = ""
    @State var error: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 20) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                UniversalButton(title: "Delete") { deleteTodolist(id) }
            }
           
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
                    .onChange(of: newTaskText) { oldValue, newValue in
                        if error && !newValue.trimmingCharacters(in: .whitespaces).isEmpty {error = false}
                    }
                
                UniversalButton(title: "Add") {
                    if newTaskText.trimmingCharacters(in: .whitespaces).isEmpty {
                        error = true
                    } else {
                        error = false
                        createTask(newTaskText, id)
                        newTaskText = ""
                    }
                }
            }
            
            if error {
                Text("⚠️ Пожалуйста, заполните поле")
                    .foregroundColor(.red)
                    .font(.system(size: 18))
                    .font(.caption)
                    .padding(.leading, 4)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                if tasks.isEmpty {
                    Text("Список пуст")
                }
                
                ForEach(tasks) { el in
                    HStack(spacing: 20) {
                        Image(el.isDone ? .yes : .stop)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                changeTasksStatus(el.id, !el.isDone, id)
                            }
                        
                        Text(el.title)
                            .font(.system(size: 18))
                            .strikethrough(!el.isDone, color: .red)
                        
                        Spacer()
                        
                        UniversalButton(title: "Delete") {
                            print(el.id)
                            deleteTask(el.id, id)
                        }
                    }
                }
            }
            
            HStack(spacing: 16) {
                UniversalButton(
                    title: FilterValuesType.all.rawValue,
                    onClickHandler: { changeFilter(.all, id) },
                    isActive: filter == .all
                )
                UniversalButton(
                    title: FilterValuesType.active.rawValue,
                    onClickHandler: { changeFilter(.active, id) },
                    isActive: filter == .active
                )
                UniversalButton(
                    title: FilterValuesType.completed.rawValue,
                    onClickHandler: { changeFilter(.completed, id) },
                    isActive: filter == .completed
                )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.yellow.opacity(0.3))
                .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        )
        .shadow(color: .black.opacity(0.5), radius: 9, x: 9, y: 9)
        .padding()
    }
}
