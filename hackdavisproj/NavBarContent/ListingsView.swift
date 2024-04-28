import SwiftUI

struct ListingsView: View {
    @ObservedObject var eventData: EventData  // Observing the shared data model

    var body: some View {
        List {
            ForEach(eventData.events) { event in
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
        .navigationTitle("Volunteer Opportunities Listings")
    }
}
