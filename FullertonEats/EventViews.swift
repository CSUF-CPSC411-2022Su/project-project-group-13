//
//  EventViews.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/16/22.
//

import SwiftUI

struct MyEventsView: View {
    @EnvironmentObject var user: User
    @State var showingAddEventSheet = false
    var loader = UserLoader()

    var body: some View {
        ZStack {
            BackgroundDesign()
            VStack {
                HStack {
                    addButton
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("My Events")
                        .modifier(TitleModifier())
                    
                    Spacer()
                    
                    editButton
                        .padding(.trailing, 20)
                }
                
                List {
                    ForEach(user.myEvents, id: \.self) { event in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(event.label)
                                    .lineLimit(1)
                                        
                                Text(event.address)
                                    .font(.subheadline)
                                    .fontWeight(.ultraLight)
                                    .lineLimit(1)
                            }
                            .foregroundColor(.black)
                        
                            Spacer()
                        }
                    }
                    .onDelete {
                        offset in
                        user.myEvents.remove(atOffsets: offset)
                        loader.saveUser(user: user)
                    }
                    .onMove {
                        offset, index in
                        user.myEvents.move(fromOffsets: offset, toOffset: index)
                        loader.saveUser(user: user)
                    }
                }
                .shadow(radius: 15)
            }
        }
        .hiddenNavigationBarStyle()
        .onAppear {
            showingAddEventSheet = false
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    var addButton: some View {
        Button("Add") {
            showingAddEventSheet = true
        }
        .sheet(isPresented: $showingAddEventSheet) {
            AddEventSheet()
        }
        .modifier(ButtonModifier())
    }
    
    var editButton: some View {
        EditButton().modifier(ButtonModifier())
    }
}

struct FavoritedEventsView: View {
    @EnvironmentObject var user: User
    var loader = UserLoader()
    
    var body: some View {
        ZStack {
            BackgroundDesign()
            VStack {
                HStack {
                    sampleButton
                        .padding(.leading, 20)
                    
                    Spacer()
                        
                    Text("Favorited Events")
                        .modifier(TitleModifier())
                    
                    Spacer()
                    
                    EditButton()
                        .modifier(ButtonModifier())
                        .padding(.trailing, 20)
                }
                
                List {
                    ForEach(user.favoritedEvents.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.favoritedEvents[index].label)
                                    .lineLimit(1)
                                    
                                Text(user.favoritedEvents[index].address)
                                    .font(.subheadline)
                                    .fontWeight(.ultraLight)
                                    .lineLimit(1)
                            }
                            .foregroundColor(.black)
                        
                            Spacer()
                        }
                    }
                    .onDelete {
                        offset in
                        user.favoritedEvents.remove(atOffsets: offset)
                        loader.saveUser(user: user)
                    }
                    .onMove {
                        offset, index in
                        user.favoritedEvents.move(fromOffsets: offset, toOffset: index)
                        loader.saveUser(user: user)
                    }
                }
                .shadow(radius: 15)
            }
        }
        .hiddenNavigationBarStyle()
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    // Adds sample favorited events
    var sampleButton: some View {
        Button("Sample") {
            user.favoritedEvents.append(Event(label: "Bread and Water", desc: "All types of bread and water", address: "Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
            
            user.favoritedEvents.append(Event(label: "Soup", desc: "Tomato and chicken noodle soup!", address: "Gymnasium Campus Dr. Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
            
            user.favoritedEvents.append(Event(label: "Fruits", desc: "All types of fruit served here!", address: "Engineering and Computer Science Buildings, Fullerton, CA 92831", date: Date(), startTime: Date(), endTime: Date()))
            
            loader.saveUser(user: user)
        }
        .modifier(ButtonModifier())
    }
}

// Add form for My Events
struct AddEventSheet: View {
    @EnvironmentObject var user: User
    @State var label: String = ""
    @State var desc: String = ""
    @State var address: String = ""
    @State var date: Date = .init()
    @State var startTime: Date = .init()
    @State var endTime: Date = .init()
    @State var showErrorMessage: Bool = false
    var loader = UserLoader()
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .modifier(ButtonModifier())
                    .padding(.leading)
                    
                    Spacer()
                    
                    saveButton
                        .padding(.trailing)
                }.padding(.top, 10)
                
                List {
                    labelSection
                    descSection
                    addressSection
                    dateSection
                    timeSection
                }
            }
            .background(Color.CSUFBlue())
            ErrorMessage(showErrorMessage: $showErrorMessage)
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .white
        }
    }
    
    var labelSection: some View {
        Section(header: Text("Label")
            .modifier(HeaderModifier())) {
                TextField("Label", text: $label)
            }
    }
    
    var descSection: some View {
        Section(header: Text("Description")
            .modifier(HeaderModifier())) {
                TextField("Description", text: $desc)
            }
    }
    
    var addressSection: some View {
        Section(header: Text("Address")
            .modifier(HeaderModifier())) {
                TextField("Address", text: $address)
            }
    }
    
    var dateSection: some View {
        Section(header: Text("Date")
            .modifier(HeaderModifier())) {
                DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
            }
    }
    
    var timeSection: some View {
        Section(header: Text("Time")
            .modifier(HeaderModifier())) {
                DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)

                DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
            }
    }
    
    var saveButton: some View {
        Button(action: {
            if !label.isEmpty, !address.isEmpty {
                let newEvent = Event(label: label, desc: desc, address: address, date: date, startTime: startTime, endTime: endTime)

                user.myEvents.append(newEvent)
                loader.saveUser(user: user)
                presentationMode.wrappedValue.dismiss()
            } else {
                showErrorMessage = true
            }
        }) {
            Text("Save")
                .modifier(ButtonModifier())
        }
    }
}

//// Edit Form for My Events
//struct EditEventSheet: View {
//    @EnvironmentObject var user: User
//    @Binding var event: Event
//    @State var label: String = ""
//    @State var desc: String = ""
//    @State var address: String = ""
//    @State var date: Date = .init()
//    @State var startTime: Date = .init()
//    @State var endTime: Date = .init()
//    @State var showErrorMessage: Bool = false
//    var loader = UserLoader()
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        ZStack {
//            VStack {
//                HStack {
//                    Button("Cancel") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                    .modifier(ButtonModifier())
//                    .padding(.leading)
//
//                    Spacer()
//
//                    doneButton
//                        .padding(.trailing)
//                }.padding(.top, 10)
//
//                List {
//                    labelSection
//                    descSection
//                    addressSection
//                    dateSection
//                    timeSection
//                }
//            }
//            .background(Color.CSUFBlue())
//
//            ErrorMessage(showErrorMessage: $showErrorMessage)
//        }
//        .onAppear {
//            UITableView.appearance().backgroundColor = .white
//        }
//    }
//
//    var labelSection: some View {
//        Section(header: Text("Label").modifier(HeaderModifier())) {
//            TextField("", text: $label)
//                .onAppear {
//                    self.label = event.label
//                }
//        }
//    }
//
//    var descSection: some View {
//        Section(header: Text("Description").modifier(HeaderModifier())) {
//            TextField("", text: $desc)
//                .onAppear {
//                    self.desc = event.desc
//                }
//        }
//    }
//
//    var addressSection: some View {
//        Section(header: Text("Address").modifier(HeaderModifier())) {
//            TextField("", text: $address)
//                .onAppear {
//                    self.address = event.address
//                }
//        }
//    }
//
//    var dateSection: some View {
//        Section(header: Text("Date").modifier(HeaderModifier())) {
//            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
//                .labelsHidden()
//                .datePickerStyle(WheelDatePickerStyle())
//                .onAppear {
//                    self.date = event.date
//                }
//        }
//    }
//
//    var timeSection: some View {
//        Section(header: Text("Time")
//            .modifier(HeaderModifier())) {
//                DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)
//                    .onAppear {
//                        self.startTime = event.startTime
//                    }
//
//                DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
//                    .onAppear {
//                        self.endTime = event.endTime
//                    }
//            }
//    }
//
//    var doneButton: some View {
//        Button(action: {
//            if !label.isEmpty, !address.isEmpty {
//                event.update(label: label, desc: desc, address: address, date: date, startTime: startTime, endTime: endTime)
//
//                loader.saveUser(user: user)
//                presentationMode.wrappedValue.dismiss()
//            } else {
//                showErrorMessage = true
//            }
//        }) {
//            Text("Done").modifier(ButtonModifier())
//        }
//    }
//}


//struct MyEventInfoSheet: View {
//    @Binding var event: Event
//    var dateFormat = DateFormatter()
//    var timeFormat = DateFormatter()
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack {
//            HStack {
//                Spacer()
//                Button("Back") {
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .modifier(ButtonModifier())
//                .padding(.trailing)
//            }
//            .padding(.top, 10.0)
//            List {
//                Section(header: Text("Label").modifier(HeaderModifier())) {
//                    Text(event.label)
//                }
//
//                Section(header: Text("Description").modifier(HeaderModifier())) {
//                    Text(event.desc)
//                }
//
//                Section(header: Text("Address").modifier(HeaderModifier())) {
//                    Text(event.address)
//                }
//
//                Section(header: Text("Date").modifier(HeaderModifier())) {
//                    Text(dateFormat.string(from: event.date))
//                }
//
//                Section(header: Text("Time").modifier(HeaderModifier())) {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text("Start")
//                            Spacer()
//                            Text(timeFormat.string(from: event.startTime))
//                        }
//
//                        HStack {
//                            Text("End")
//                            Spacer()
//                            Text(timeFormat.string(from: event.endTime))
//                        }
//                    }
//                }
//            }
//        }
//        .background(Color.CSUFBlue())
//        .onAppear {
//            dateFormat.dateStyle = .short
//            timeFormat.timeStyle = .short
//            UITableView.appearance().backgroundColor = .white
//        }
//    }
//}

//struct FavEventInfoSheet: View {
//    @Binding var event: Event
//    var dateFormat = DateFormatter()
//    var timeFormat = DateFormatter()
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack {
//            HStack {
//                Spacer()
//                Button("Back") {
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .modifier(ButtonModifier())
//                .padding(.trailing)
//            }
//            .padding(.top, 10.0)
//            List {
//                Section(header: Text("Label").modifier(HeaderModifier())) {
//                    Text(event.label)
//                }
//
//                Section(header: Text("Description").modifier(HeaderModifier())) {
//                    Text(event.desc)
//                }
//
//                Section(header: Text("Address").modifier(HeaderModifier())) {
//                    Text(event.address)
//                }
//
//                Section(header: Text("Date").modifier(HeaderModifier())) {
//                    Text(dateFormat.string(from: event.date))
//                }
//
//                Section(header: Text("Time").modifier(HeaderModifier())) {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text("Start")
//                            Spacer()
//                            Text(timeFormat.string(from: event.startTime))
//                        }
//
//                        HStack {
//                            Text("End")
//                            Spacer()
//                            Text(timeFormat.string(from: event.endTime))
//                        }
//                    }
//                }
//            }
//        }
//        .background(Color.CSUFBlue())
//        .onAppear {
//            dateFormat.dateStyle = .short
//            timeFormat.timeStyle = .short
//            UITableView.appearance().backgroundColor = .white
//        }
//    }
//}

struct BackgroundDesign: View {
    var body: some View {
        Color.CSUFBlue()
            .ignoresSafeArea()
        Circle()
            .scale(1.5)
            .foregroundColor(.white)
        Circle()
            .scale(1.25)
            .foregroundColor(Color.CSUFOrange())
    }
}

struct ErrorMessage: View {
    @Binding var showErrorMessage: Bool
    
    var body: some View {
        ZStack {
            if showErrorMessage {
                VStack(alignment: .center, spacing: 0) {
                    Text("Label and Address cannot be empty.")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        showErrorMessage = false
                    }) {
                        Text("Dismiss")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50, alignment: .center)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(Color.CSUFBlue())
                }
                .frame(maxWidth: 300)
                .background(.white)
                .cornerRadius(16)
                .shadow(radius: 5)
            }
        }
    }
}

struct EventsForm_Previews: PreviewProvider {
    static var previews: some View {
        // MyEventsView()
        FavoritedEventsView()
    }
}
