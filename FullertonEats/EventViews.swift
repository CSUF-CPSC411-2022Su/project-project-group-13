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
    @State var showingEditEventSheet = false
    @State var showingInfoSheet = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }

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
                    ForEach(Array(self.user.myEvents.enumerated()), id: \.1) { index, event in
                        HStack {
                            Button(action: {
                                showingInfoSheet.toggle()
                            }) {
                                VStack(alignment: .leading) {
                                    Text(event.label)
                                        .lineLimit(1)
                                        
                                    Text(event.address)
                                        .font(.subheadline)
                                        .fontWeight(.ultraLight)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(.black)
                            .sheet(isPresented: $showingInfoSheet) {
                                InfoSheet(index: index, of: "myEvents")
                            }
                        
                            Spacer()
                        
                            editEventbutton
                                .buttonStyle(BorderlessButtonStyle())
                                .sheet(isPresented: $showingEditEventSheet) {
                                    EditEventSheet(index: index)
                                }
                        }
                    }
                    .onDelete {
                        offset in
                        user.myEvents.remove(atOffsets: offset)
                    }
                    .onMove {
                        offset, index in
                        user.myEvents.move(fromOffsets: offset, toOffset: index)
                    }
                }
                .shadow(radius: 15)
            }
        }
        .hiddenNavigationBarStyle()
    }
    
    var addButton: some View {
        Button("Add") {
            showingAddEventSheet.toggle()
        }
        .sheet(isPresented: $showingAddEventSheet) {
            AddEventSheet()
        }
        .modifier(ButtonModifier())
    }
    
    var editButton: some View {
        EditButton().modifier(ButtonModifier())
    }
    
    var editEventbutton: some View {
        Button(action: {
            showingEditEventSheet.toggle()
        }) {
            Image(systemName: "pencil")
                .foregroundColor(.CSUFOrange())
        }
    }
}

struct FavoritedEventsView: View {
    @EnvironmentObject var user: User
    @State var showingInfoSheet = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            BackgroundDesign()
            VStack {
                HStack {
                    Spacer()
                        .frame(width: 106)
                        
                    Text("Favorited Events")
                        .modifier(TitleModifier())
                    
                    Spacer()
                    
                    EditButton()
                        .modifier(ButtonModifier())
                        .padding(.trailing, 20)
                }
                
                List {
                    ForEach(Array(self.user.favoritedEvents.enumerated()), id: \.1) { index, event in
                        HStack {
                            Button(action: {
                                showingInfoSheet.toggle()
                            }) {
                                VStack(alignment: .leading) {
                                    Text(event.label)
                                        .lineLimit(1)
                                        
                                    Text(event.address)
                                        .font(.subheadline)
                                        .fontWeight(.ultraLight)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(.black)
                            .sheet(isPresented: $showingInfoSheet) {
                                InfoSheet(index: index, of: "favoritedEvents")
                            }
                        
                            Spacer()
                        }
                    }
                    .onDelete {
                        offset in
                        user.favoritedEvents.remove(atOffsets: offset)
                    }
                    .onMove {
                        offset, index in
                        user.favoritedEvents.move(fromOffsets: offset, toOffset: index)
                    }
                }
                .shadow(radius: 15)
            }
        }
        .hiddenNavigationBarStyle()
    }
}

struct AddEventSheet: View {
    @EnvironmentObject var user: User
    @State var label: String = ""
    @State var desc: String = ""
    @State var address: String = ""
    @State var date: Date = .init()
    @State var startTime: Date = .init()
    @State var endTime: Date = .init()
    @State var showErrorMessage: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        UITableView.appearance().backgroundColor = .white
    }

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
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
                dismiss()
            } else {
                showErrorMessage.toggle()
            }
        }) {
            Text("Save")
                .modifier(ButtonModifier())
        }
    }
}

struct EditEventSheet: View {
    @EnvironmentObject var user: User
    @State var label: String = ""
    @State var desc: String = ""
    @State var address: String = ""
    @State var date: Date = .init()
    @State var startTime: Date = .init()
    @State var endTime: Date = .init()
    @State var showErrorMessage: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var index: Int
    
    init(index: Int) {
        self.index = index
        UITableView.appearance().backgroundColor = .white
    }

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .modifier(ButtonModifier())
                    .padding(.leading)
                    
                    Spacer()
                    
                    doneButton
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
    }
    
    var labelSection: some View {
        Section(header: Text("Label").modifier(HeaderModifier())) {
            TextField("", text: $label)
                .onAppear {
                    self.label = user.myEvents[index].label
                }
        }
    }
    
    var descSection: some View {
        Section(header: Text("Description").modifier(HeaderModifier())) {
            TextField("", text: $desc)
                .onAppear {
                    self.desc = user.myEvents[index].desc
                }
        }
    }
    
    var addressSection: some View {
        Section(header: Text("Address").modifier(HeaderModifier())) {
            TextField("", text: $address)
                .onAppear {
                    self.address = user.myEvents[index].address
                }
        }
    }
    
    var dateSection: some View {
        Section(header: Text("Date").modifier(HeaderModifier())) {
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .onAppear {
                    self.date = user.myEvents[index].date
                }
        }
    }
    
    var timeSection: some View {
        Section(header: Text("Time")
            .modifier(HeaderModifier())) {
                DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)
                    .onAppear {
                        self.startTime = user.myEvents[index].startTime
                    }

                DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
                    .onAppear {
                        self.endTime = user.myEvents[index].endTime
                    }
            }
    }
    
    var doneButton: some View {
        Button(action: {
            if !label.isEmpty, !address.isEmpty {
                user.myEvents[index].update(label: label, desc: desc, address: address, date: date, startTime: startTime, endTime: endTime)
                
                dismiss()
            } else {
                showErrorMessage.toggle()
            }
        }) {
            Text("Done").modifier(ButtonModifier())
        }
    }
}

struct InfoSheet: View {
    @EnvironmentObject var user: User
    
    @Environment(\.dismiss) var dismiss
    
    var index: Int
    var arrayType: String
    var dateFormat = DateFormatter()
    var timeFormat = DateFormatter()
    
    init(index: Int, of arrayType: String) {
        self.index = index
        dateFormat.dateStyle = .short
        timeFormat.timeStyle = .short
        self.arrayType = arrayType
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        if arrayType == "myEvents" {
            myEventsInfoView
        } else {
            FavoritedEventsInfoView
        }
    }
    
    var myEventsInfoView: some View {
        VStack {
            HStack {
                Spacer()
                Button("Back") {
                    dismiss()
                }
                .modifier(ButtonModifier())
                .padding(.trailing)
            }
            .padding(.top, 10.0)
            List {
                Section(header: Text("Label").modifier(HeaderModifier())) {
                    Text(user.myEvents[index].label)
                }
                
                Section(header: Text("Description").modifier(HeaderModifier())) {
                    Text(user.myEvents[index].desc)
                }
   
                Section(header: Text("Address").modifier(HeaderModifier())) {
                    Text(user.myEvents[index].address)
                    
                    // Image placeholder
                    Image(systemName: "compass.drawing")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300, alignment: .center)
                        .clipShape(Rectangle())
                        .overlay(Rectangle()
                            .frame(width: 300, height: 300)
                            .foregroundColor(Color.white)
                        )
                        .shadow(radius: 5)
                }
                
                Section(header: Text("Date").modifier(HeaderModifier())) {
                    Text(dateFormat.string(from: user.myEvents[index].date))
                }
                
                Section(header: Text("Time").modifier(HeaderModifier())) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Start")
                            Spacer()
                            Text(timeFormat.string(from: user.myEvents[index].startTime))
                        }
                        
                        HStack {
                            Text("End")
                            Spacer()
                            Text(timeFormat.string(from: user.myEvents[index].endTime))
                        }
                    }
                }
            }
        }
        .background(Color.CSUFBlue())
    }
    
    var FavoritedEventsInfoView: some View {
        VStack {
            HStack {
                Spacer()
                Button("Back") {
                    dismiss()
                }
                .modifier(ButtonModifier())
                .padding(.trailing)
            }
            .padding(.top, 10.0)
            List {
                Section(header: Text("Label").modifier(HeaderModifier())) {
                    Text(user.favoritedEvents[index].label)
                }
                
                Section(header: Text("Description").modifier(HeaderModifier())) {
                    Text(user.favoritedEvents[index].desc)
                }
   
                Section(header: Text("Address").modifier(HeaderModifier())) {
                    Text(user.favoritedEvents[index].address)
                    
                    // Image placeholder
                    Image(systemName: "compass.drawing")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipShape(Rectangle())
                        .overlay(Rectangle()
                            .frame(width: 300, height: 300)
                            .foregroundColor(Color.white)
                        )
                        .shadow(radius: 5)
                }
                
                Section(header: Text("Date").modifier(HeaderModifier())) {
                    Text(dateFormat.string(from: user.favoritedEvents[index].date))
                }
                
                Section(header: Text("Time").modifier(HeaderModifier())) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Start")
                            Spacer()
                            Text(timeFormat.string(from: user.favoritedEvents[index].startTime))
                        }
                        
                        HStack {
                            Text("End")
                            Spacer()
                            Text(timeFormat.string(from: user.favoritedEvents[index].endTime))
                        }
                    }
                }
            }
        }
        .background(Color.CSUFBlue())
    }
}

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
