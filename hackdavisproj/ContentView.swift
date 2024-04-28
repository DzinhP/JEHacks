import SwiftUI

struct ContentView: View {
    @StateObject var eventData = EventData()  // Manages event data across the app.
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false  // Persists login state across app launches.

    var body: some View {
        Group {
            if isUserLoggedIn {
                mainContentView
                    .transition(.move(edge: .trailing))  // Transition for logging in
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn, userService: UserService(context: PersistenceController.shared.viewContext))
                    .transition(.move(edge: .leading))  // Transition for logging out
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isUserLoggedIn)  // Smooth animation for the transition
    }

    private var mainContentView: some View {
        TabView {
            SearchView(eventData: eventData)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ProfileView(isUserLoggedIn: $isUserLoggedIn, eventData: eventData)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            ListingsView(eventData: eventData)
                .tabItem {
                    Label("Listings", systemImage: "list.bullet")
                }
        }
    }
    
    func logout() {
        isUserLoggedIn = false
        eventData.events.removeAll()  // Clear event data on logout
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
