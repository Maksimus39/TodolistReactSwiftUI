import SwiftUI


struct UniversalButton : View {
    let title: String
    
    var body: some View {
        Button(title) {}
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
    }
}
