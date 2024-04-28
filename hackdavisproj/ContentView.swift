import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            ListingsView()
                .tabItem {
                    Label("Listings", systemImage: "list.bullet")
                }
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
