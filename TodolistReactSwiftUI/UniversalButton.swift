import SwiftUI

struct UniversalButton: View {
    let title: String
    let onClickHandler: () -> Void
    var isActive: Bool? = nil
    
    var body: some View {
        Button(title) {
            onClickHandler()
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isActive == true ? .green : .white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isActive == true ? .black : .orange, lineWidth: 1)
        )
        .foregroundColor(isActive == true ? .white : .black)
    }
}
