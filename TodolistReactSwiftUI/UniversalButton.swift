import SwiftUI

struct UniversalButton: View {
    let title: String
    let onClickHandler: () -> Void
    var isActive: Bool? = nil
    
    var body: some View {
        Button(action: onClickHandler) {
            Text(title)
                .font(.caption)
                .fontWeight(isActive == true ? .semibold : .regular)
                .foregroundStyle(isActive == true ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(isActive == true ? Color.blue : Color(uiColor: .systemGray5))
                )
        }
        .buttonStyle(.plain) 
    }
}
