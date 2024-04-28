import Foundation

struct VolunteerEvent: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
}

class EventData: ObservableObject {
    @Published var events: [VolunteerEvent] = []
    @Published var signedUpEvents: [VolunteerEvent] = []

    init() {
        // Adding a sample event for testing and development
        self.events = [
            VolunteerEvent(title: "Beach Cleanup",
                           description: "Join us to clean the Seal beach and help marine life!",
                           date: Date())  // Use the current date for simplicity
        ]
    }

    func signUp(for event: VolunteerEvent) {
        if !isSignedUp(for: event) {
            signedUpEvents.append(event)
        }
    }

    func isSignedUp(for event: VolunteerEvent) -> Bool {
        return signedUpEvents.contains(where: { $0.id == event.id })
    }
}
