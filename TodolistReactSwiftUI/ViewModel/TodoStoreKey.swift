import SwiftUI



private struct TodoStoreKey: EnvironmentKey {
    static let defaultValue: ContentViewModel? = nil
}


extension EnvironmentValues {
    var todoStore: ContentViewModel? {
        get { self[TodoStoreKey.self] }
        set { self[TodoStoreKey.self] = newValue }
    }
}


extension View {
    func provideTodoStore(_ store: ContentViewModel) -> some View {
        environment(\.todoStore, store)
    }
}
