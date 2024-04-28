import SwiftUI

struct ContentView: View {
    @StateObject var eventData = EventData()  // Manage the event data
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false  // Persisted user login state

    var body: some View {
        Group {
            if isUserLoggedIn {
                TabView {
                    SearchView(eventData: eventData)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    
                    ProfileView(isUserLoggedIn: $isUserLoggedIn, eventData:eventData)
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    
                    ListingsView(eventData: eventData)
                        .tabItem {
                            Label("Listings", systemImage: "list.bullet")
                        }
                }
                .transition(.move(edge: .trailing))  // Transition for the main content
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
                    .transition(.move(edge: .leading))  // Transition for the login view
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isUserLoggedIn)  // Animation for switching states
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
