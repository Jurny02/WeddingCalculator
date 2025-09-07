import SwiftUI

struct SnackbarView: View {
    let style: SnackbarConfig

    var body: some View {
        HStack(spacing: 12) {
            style.icon
                .foregroundColor(.white)
                .imageScale(.large)

            Text(style.message)
                .foregroundColor(.white)
                .font(.body)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(14)
        .background(style.backgroundColor)
        .cornerRadius(16)
        .shadow(radius: 6)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack(
        spacing: 20
    ) {
        SnackbarView(
            style: .success(message: "Dane zapisane poprawnie")
        )

        SnackbarView(
            style: .error(message: "Dane zapisane poprawnie")
        )

        SnackbarView(
            style: .info(message: "Dane zapisane poprawnie")
        )

        SnackbarView(
            style: .warning(message: "Dane zapisane poprawnie")
        )
    }
    .padding()
}
