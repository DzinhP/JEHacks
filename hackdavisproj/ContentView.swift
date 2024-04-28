import SwiftUI


struct ContentView: View {
    @StateObject var eventData = EventData()  // This ensures it's created once and observed by any views that need it.
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false  // This persists the login state across app launches.
    
    var body: some View {
        if isUserLoggedIn {
            TabView {
                SearchView(eventData: eventData)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                ProfileView(isUserLoggedIn: $isUserLoggedIn, eventData: eventData)  // Pass eventData to ProfileView
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                
                ListingsView(eventData: eventData)
                    .tabItem {
                        Label("Listings", systemImage: "list.bullet")
                    }
            }
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn, userService: UserService(context: PersistenceController.shared.viewContext))
        }
    }
    
    func logout() {
        isUserLoggedIn = false
        eventData.events.removeAll()  // Clears the event data upon logout.
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
