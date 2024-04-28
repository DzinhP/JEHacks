

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
                Text("VolunteerHub")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                    .bold()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .padding(.top, -50)
                    .padding(.bottom, -100)
                
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
                
                if !errorMessage.isEmpty {
                                   Text(errorMessage)
                                       .foregroundColor(errorMessage == "Incorrect username or password" ? .red : .yellow)
                                       .padding()
                               }
                
                Button(action: isSignUp ? performSignUp : performLogin) {
                    Text(isSignUp ? "Sign Up" : "Log In")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(.color1)
                        .cornerRadius(8)
                }
                .padding()
                
                Button(isSignUp ? "Already have an account? Log In" : "Need an account? Sign Up") {
                    isSignUp.toggle()
                    errorMessage = "" // Clear error message when switching modes
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
            }
            .background(.color3) // Replace with your color
        }
    }


    private func performLogin() {
        guard let user = userService.fetchUser(withName: username), user.password == userService.hashPassword(password) else {
            errorMessage = "Incorrect username or password."
            return
        }
        errorMessage = ""
        isUserLoggedIn = true
    }


    private func performSignUp() {
        guard isSignUp, password == confirmPassword, !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields correctly."
            return
        }
        
        if userService.createUser(name: username, password: password) != nil {
            errorMessage = ""
            isUserLoggedIn = true
        } else {
            errorMessage = "Invalid. Username may already exist."
        }
        
    }
}
    


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.viewContext
        return LoginView(isUserLoggedIn: .constant(false), userService: UserService(context: context))
    }
}
