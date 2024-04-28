import SwiftUI

struct LoginView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignUp = false  // Toggle between login and sign-up

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 50)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if isSignUp {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                Button(action: isSignUp ? performSignUp : performLogin) {
                    Text(isSignUp ? "Sign Up" : "Log In")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(isSignUp ? Color.blue : Color.blue)
                        .cornerRadius(8)
                }
                .padding()

                Button(isSignUp ? "Already have an account? Log In" : "Need an account? Sign Up") {
                    isSignUp.toggle()
                }
                .padding()

                Spacer()
            }
            .navigationBarTitle(isSignUp ? "Sign Up" : "Login", displayMode: .inline)
        }
    }

    private func performLogin() {
        // Placeholder for login logic
        isUserLoggedIn = true
    }
    
    private func performSignUp() {
        // Placeholder for sign-up logic
        if password == confirmPassword {
            isUserLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
    }
}
