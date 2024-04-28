import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var eventData: EventData

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Button("Save Event") {
                    let newEvent = VolunteerEvent(title: title, description: description, date: date)
                    eventData.events.append(newEvent)
                    presentationMode.wrappedValue.dismiss()  // Dismiss the view after saving
                }
            }
            .navigationTitle("Add Event")
        }
    }
}
