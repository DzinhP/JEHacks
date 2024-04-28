import SwiftUI

struct ProfileView: View {
    @Binding var isUserLoggedIn: Bool
    @ObservedObject var eventData: EventData  // Add this line

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
                        .frame(width: 120, height: 120)
                        .padding(.top, 20)
                        .foregroundColor(.white)  // Adjust color as needed
                        .shadow(radius: 10)
                    
                    Text("Username")
                        .font(.largeTitle)
                        .foregroundColor(.white)  // Adjust color as needed
                        .shadow(radius: 5)
                        .padding([.top, .bottom], 5)
                    
                    Text("Bio goes here")
                        .font(.callout)
                        .foregroundColor(.white)  // Adjust color as needed
                        .padding(.bottom, 20)
                }
            }
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
            .padding()

            // Display signed up events
            List {
                Section(header: Text("Signed Up Events").bold().foregroundColor(.black)){
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
            VStack {
                Button("Settings") {
                    // settings action
                }
                .buttonStyle(PrimaryButtonStyle())

                Button("Log Out") {
                    isUserLoggedIn = false
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
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
