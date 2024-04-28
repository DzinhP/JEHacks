import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var eventData: EventData

    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var image: UIImage?
    @State private var showingImagePicker = false  // To control the display of the image picker

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, displayedComponents: .date)

                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }

                Button("Select Image") {
                    showingImagePicker = true
                }
                .foregroundColor(.color3).bold()
                Button("Save Event") {
                    var newEvent = VolunteerEvent(title: title, description: description, date: date)
                    newEvent.image = image
                    eventData.events.append(newEvent)
                    presentationMode.wrappedValue.dismiss()  // Dismiss the view after saving
                }
                .foregroundColor(.color3).bold()
            }
            .navigationTitle("Add Event")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $image)
            }
        }
    }
}
