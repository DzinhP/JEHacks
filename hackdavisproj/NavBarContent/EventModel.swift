import Foundation

struct VolunteerEvent: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
}

class EventData: ObservableObject {
    @Published var events: [VolunteerEvent] = []
}
