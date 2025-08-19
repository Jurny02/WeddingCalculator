import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Root View")
                NavigationLink("Go to Next View") {
                    NextView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Root Btn") {
                        print("Root button tapped")
                    }
                }
            }
        }
    }
}

struct NextView: View {
    var body: some View {
        VStack {
            Text("Next View")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next Btn") {
                    print("Next button tapped")
                }
            }
        }
    }
}

#Preview {
    RootView()
}
