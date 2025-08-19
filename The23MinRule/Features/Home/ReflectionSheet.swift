import SwiftUI
import UIKit

struct ReflectionSheet: View {
    var onResisted: () -> Void
    var onCaved: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 18) {
            Capsule().fill(Color.white.opacity(0.15))
                .frame(width: 42, height: 5)
                .padding(.top, 6)

            Text("How did it go?")
                .font(.system(size: 22, weight: .heavy))
                .foregroundColor(.appText)

            Text("Be honest — it’s about reps, not perfection.")
                .font(.system(size: 14))
                .foregroundColor(.appMuted)

            VStack(spacing: 12) {
                Button {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    onResisted()
                    dismiss()
                } label: {
                    Text("Resisted")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(colors: [.appPrimaryHi, .appPrimary],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(16)
                        .shadow(color: .appPrimary.opacity(0.45), radius: 18, x: 0, y: 10)
                }

                Button {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    onCaved()
                    dismiss()
                } label: {
                    Text("Caved")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.appText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.appCard)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.06), lineWidth: 1)
                        )
                }
            }

            Spacer(minLength: 4)
        }
        .padding(16)
        .presentationDetents([.fraction(0.36)])
        .presentationBackground(Color.appSurface)
        .presentationCornerRadius(24)
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(true)   
    }
}
