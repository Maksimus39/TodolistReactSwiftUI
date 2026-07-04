import Foundation


enum FilterValuesType: String, CaseIterable {
    case all, active, completed
}

struct TaskItem: Identifiable, Equatable {
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
