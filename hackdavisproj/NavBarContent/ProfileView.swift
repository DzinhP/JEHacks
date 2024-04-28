import SwiftUI

struct ProfileView: View {
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        VStack {
            // Your profile content here
            Spacer()
            Button("Log Out") {
                isUserLoggedIn = false
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.red)
            .cornerRadius(10)
            .padding()
        }
    }
}
