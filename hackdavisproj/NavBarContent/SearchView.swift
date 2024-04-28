import SwiftUI

struct SearchView: View {
    @ObservedObject var eventData: EventData
    @State private var searchText = ""
    @State private var showFilters = false
    @State private var showingAddEventView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                                    Spacer() // This spacer will push everything after it to the right
                                    Image("logo") // Your logo here
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150) // Adjust the size as necessary
                                        .padding(.top,-80)
                                        .padding(.bottom, -30)
                                }
                                .padding(.horizontal,15) // Add horizontal padding if needed
                
                TextField("Search by keywords, location...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()

                Button("Filter Options") {
                    showFilters.toggle()
                }
                .foregroundColor(.color3)
                .sheet(isPresented: $showFilters) {
                    FilterView()  // Assuming FilterView exists and works independently
                }

                Button("Add Volunteer Opportunity") {
                    showingAddEventView = true
                }
                .padding()
                .foregroundColor(.white)
                .background(.color3)
                .cornerRadius(8)
                


                List {
                    ForEach(eventData.events.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) }) { event in
                        DisclosureGroup {
                            VStack(alignment: .leading) {
                                (Text("Description: ").bold() + Text(event.description))
                                    .padding()
                                (Text("Date: ").bold() + Text(event.date, style: .date))
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
                .foregroundColor(.black)
            }
            .sheet(isPresented: $showingAddEventView) {
                AddEventView(eventData: eventData)
            }
        }
    }
}
