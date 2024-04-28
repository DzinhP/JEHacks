import SwiftUI

struct ContentView: View {
    @StateObject var eventData = EventData()  // Manage the event data
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false  // Persisted user login state

    var body: some View {
        if isUserLoggedIn {
            TabView {
                SearchView(eventData: eventData)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                ProfileView(isUserLoggedIn: $isUserLoggedIn)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                
                ListingsView(eventData: eventData)
                    .tabItem {
                        Label("Listings", systemImage: "list.bullet")
                    }
                
          
            }
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn)
        }
    }

    func logout() {
        // Any cleanup actions can be performed here
        isUserLoggedIn = false
        // Reset event data or clear any sensitive information if necessary
        eventData.events.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
