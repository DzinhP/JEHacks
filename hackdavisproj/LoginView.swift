
import SwiftUI


struct LoginView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignUp = false
    @State private var errorMessage = ""
    var userService: UserService


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
                        .background(Color.blue)
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
        guard let user = userService.fetchUser(withName: username), user.password == userService.hashPassword(password) else {
            errorMessage = "Incorrect username or password."
            return
        }
        isUserLoggedIn = true
    }


    private func performSignUp() {
        guard isSignUp, password == confirmPassword, !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields correctly."
            return
        }
        
        if userService.createUser(name: username, password: password) != nil {
            print("User created successfully.")
            isUserLoggedIn = true
        } else {
            errorMessage = "Failed to create user. Username may already exist."
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.viewContext
        return LoginView(isUserLoggedIn: .constant(false), userService: UserService(context: context))
    }
}
