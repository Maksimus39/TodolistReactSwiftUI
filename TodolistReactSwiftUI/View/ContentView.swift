import SwiftUI

struct ContentView: View {
    @Environment(\.todoStore) private var store
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if let store {
                        AddListForm()
                            .padding(.horizontal)
                        
                        ForEach(store.state.todolists) { list in
                            TodolistItem(list: list)
                        }
                    }
                }
            }
            .padding(.vertical)
            .navigationTitle(Constants.myProject)
            .navigationBarTitleDisplayMode(.inline)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color(.systemGroupedBackground))
    }
}
