import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var showFilters = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by keywords, location...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()

                Button("Filter Options") {
                    showFilters.toggle()
                }
                .sheet(isPresented: $showFilters) {
                    FilterView()
                }

                List {
                    Text("Search Results")
                }
                .navigationTitle("Volunteer Opportunities")
            }
        }
    }
}
