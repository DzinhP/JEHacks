import Foundation
import UIKit

struct VolunteerEvent: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var imageData: Data?
    var isLiked: Bool = false
    var likesCount: Int = 0
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
}

class EventData: ObservableObject {
    @Published var events: [VolunteerEvent] = []
    @Published var signedUpEvents: [VolunteerEvent] = []

    init() {
        var aggieHouseEvent = VolunteerEvent(
            title: "Aggie House",
            description: "Join us to help operate and maintain our shelter!",
            date: Date()
        )
        
        // Load and set the image separately
        aggieHouseEvent.image = UIImage(named: "AggieHouse")
        
        // Adding the event with an image
        self.events.append(aggieHouseEvent)
        
        
        
        var arboretumGarden = VolunteerEvent(
            title: "Arboretum and Public Garden",
            description: "Learn new skill and support the work of UC Davis's living museum, the Arboretum!",
            date: Date()
        )
        
        // Load and set the image separately
        arboretumGarden.image = UIImage(named: "ArboretumGarden")
        
        // Adding the event with an image
        self.events.append(arboretumGarden)
        
        
        
        var lifeOfKai = VolunteerEvent(
            title: "Life of Kai Animal Shelter",
            description: "Help animals find their forever homes with Life of Kai!",
            date: Date()
        )
        
        // Load and set the image separately
        lifeOfKai.image = UIImage(named: "LifeOfKai")
        
        // Adding the event with an image
        self.events.append(lifeOfKai)
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
