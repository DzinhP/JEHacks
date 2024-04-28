import SwiftUI

struct ProfileView: View {
    @Binding var isUserLoggedIn: Bool
    @ObservedObject var eventData: EventData  // Add this line
    var username: String = UserDefaults.standard.string(forKey: "lastLoggedInUser") ?? "Guest"

    var body: some View {
        VStack {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [.color3]), startPoint: .top, endPoint: .bottom)  // Adjust color names as needed
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.top, 20)
                        .foregroundColor(.white)  // Adjust color as needed
                        .shadow(radius: 10)
                    
                    Text("Welcome, \(username)!")
                        .font(.largeTitle)
                        .foregroundColor(.white)  // Adjust color as needed
                        .shadow(radius: 5)
                        .padding([.top, .bottom], 5)
                    
                }
            }
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
            .padding()

            // Display signed up events
            List {
                Section(header: Text("Signed Up Events").bold().foregroundColor(.black).font(.title3)){
                    ForEach(eventData.signedUpEvents) { event in
                        VStack(alignment: .leading) {
                            Text(event.title).font(.headline)
                            Text("Date: \(event.date, style: .date)")
                        }
                    }
                }
            }
        
            Spacer()

            // Settings and logout section
            HStack {
                Button("Settings") {
                    // settings action
                }
                .buttonStyle(PrimaryButtonStyle())

                Button("Log Out") {
                    UserDefaults.standard.removeObject(forKey: "lastLoggedInUser")
                    isUserLoggedIn = false
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
            Text("Email VolunteerHub@gmail.com for Feedback and Reviews")
                .bold()  // Make the text bold
                .foregroundColor(.color1)  // Set the text color to blue
                .multilineTextAlignment(.center)  // Center-align the text
                .padding()  // Add padding around the text for better spacing in the UI

        }
        .background(LinearGradient(gradient: Gradient(colors: [.color5]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}

// Custom Button Style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(.color3)  // Adjust color as needed
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .shadow(radius: configuration.isPressed ? 0 : 5)
    }
}
