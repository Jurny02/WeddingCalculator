import SwiftUI

struct SnackBarView: View {
    let style: SnackBarConfig

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
        SnackBarView(
            style: .success(message: "Dane zapisane poprawnie")
        )

        SnackBarView(
            style: .error(message: "Dane zapisane poprawnie")
        )

        SnackBarView(
            style: .info(message: "Dane zapisane poprawnie")
        )

        SnackBarView(
            style: .warning(message: "Dane zapisane poprawnie")
        )
    }
    .padding()
}
