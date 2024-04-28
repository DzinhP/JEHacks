import SwiftUI

struct ListingsView: View {
    @ObservedObject var eventData: EventData
    
    var body: some View {
        List {
            ForEach(eventData.events) { event in
                VStack(alignment: .leading) {
                    DisclosureGroup {
                        VStack(alignment: .leading) {
                            if let image = event.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(10)
                            }
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
                    
                    if !eventData.isSignedUp(for: event) {
                        Button("Sign Up") {
                            eventData.signUp(for: event)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.color3)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Volunteer Opportunities Listings")
        }
    }
}

