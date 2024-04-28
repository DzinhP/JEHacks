import SwiftUI

struct SearchView: View {
    @ObservedObject var eventData: EventData
    @State private var searchText = ""
    @State private var showFilters = false
    @State private var showingAddEventView = false

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
                    FilterView()  // Assuming FilterView exists and works independently
                }

                Button("Add Volunteer Opportunity") {
                    showingAddEventView = true
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)

                List {
                    ForEach(eventData.events.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) }) { event in
                        DisclosureGroup {
                            VStack(alignment: .leading) {
                                Text("Description: \(event.description)")
                                    .padding()
                                Text("Date: \(event.date, style: .date)")
                                    .padding()
                            }
                        } label: {
                            Text(event.title)
                                .font(.headline)
                                .padding()
                        }
                    }
                }
                .navigationTitle("Volunteering")
            }
            .sheet(isPresented: $showingAddEventView) {
                AddEventView(eventData: eventData)
            }
        }
    }
}
