//
//  ServiceViews.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/16/22.
//

import SwiftUI

struct ServiceView: View {
    @StateObject var user = User(username: "user", password: "pw")
    
    @State var showingAddServiceSheet = false
    @State var showingEditServiceSheet = false
    @State var showingInfoSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(self.user.myServices.enumerated()), id: \.1) { index, service in
                    HStack {
                        Button(action: {
                            showingInfoSheet.toggle()
                        }) {
                            VStack(alignment: .leading) {
                                Text(service.label)
                                    .lineLimit(1)
                                        
                                Text(service.address)
                                    .font(.subheadline)
                                    .fontWeight(.ultraLight)
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .foregroundColor(.black)
                        .sheet(isPresented: $showingInfoSheet) {
                            InfoSheet(index: index)
                        }
                        
                        Spacer()
                        
                        editServiceButton
                            .buttonStyle(BorderlessButtonStyle())
                            .sheet(isPresented: $showingEditServiceSheet) {
                                EditServiceSheet(index: index)
                            }
                    }
                }
                .onDelete {
                    offset in
                    user.myServices.remove(atOffsets: offset)
                }
                .onMove {
                    offset, index in
                    user.myServices.move(fromOffsets: offset, toOffset: index)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addButton
                }
                
                ToolbarItem(placement: .principal) {
                    Text("My Services").bold()
                        .foregroundColor(.CSUFBlue())
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton
                }
            }
        }
        .environmentObject(user)
        .navigationBarBackButtonHidden(true)
    }
    
    var addButton: some View {
        Button("Add") {
            showingAddServiceSheet.toggle()
        }
        .sheet(isPresented: $showingAddServiceSheet) {
            AddServiceSheet()
        }
        .modifier(ButtonModifier())
    }
    
    var editButton: some View {
        EditButton().modifier(ButtonModifier())
    }
    
    var editServiceButton: some View {
        Button(action: {
            showingEditServiceSheet.toggle()
        }) {
            Image(systemName: "pencil")
                .foregroundColor(.CSUFOrange())
        }
    }
}

struct AddServiceSheet: View {
    @EnvironmentObject var user: User
    @State var label: String = ""
    @State var desc: String = ""
    @State var address: String = ""
    @State var date: Date = .init()
    @State var startTime: Date = .init()
    @State var endTime: Date = .init()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
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
                let newService = Service(label: label, desc: desc, address: address, date: date, startTime: startTime, endTime: endTime)

                user.myServices.append(newService)
                dismiss()
            } else {
                // TODO: -> popup error message
                print("error")
            }
        }) {
            Text("Save")
                .modifier(ButtonModifier())
        }
    }
}

struct EditServiceSheet: View {
    @EnvironmentObject var user: User
    @State var label: String = ""
    @State var desc: String = ""
    @State var address: String = ""
    @State var date: Date = .init()
    @State var startTime: Date = .init()
    @State var endTime: Date = .init()
    
    @Environment(\.dismiss) var dismiss
    
    var index: Int
    
    init(index: Int) {
        self.index = index
    }

    var body: some View {
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
    }
    
    var labelSection: some View {
        Section(header: Text("Label").modifier(HeaderModifier())) {
            TextField("", text: $label)
                .onAppear {
                    self.label = user.myServices[index].label
                }
        }
    }
    
    var descSection: some View {
        Section(header: Text("Description").modifier(HeaderModifier())) {
            TextField("", text: $desc)
                .onAppear {
                    self.desc = user.myServices[index].desc
                }
        }
    }
    
    var addressSection: some View {
        Section(header: Text("Address").modifier(HeaderModifier())) {
            TextField("", text: $address)
                .onAppear {
                    self.address = user.myServices[index].address
                }
        }
    }
    
    var dateSection: some View {
        Section(header: Text("Date").modifier(HeaderModifier())) {
            DatePicker("", selection: $date, in: Date.now..., displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .onAppear {
                    self.date = user.myServices[index].date
                }
        }
    }
    
    var timeSection: some View {
        Section(header: Text("Time")
            .modifier(HeaderModifier())) {
                DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)
                    .onAppear {
                        self.startTime = user.myServices[index].startTime
                    }

                DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
                    .onAppear {
                        self.endTime = user.myServices[index].endTime
                    }
            }
    }
    
    var doneButton: some View {
        Button(action: {
            user.myServices[index].update(label: label, desc: desc, address: address, date: date, startTime: startTime, endTime: endTime)
            
            dismiss()
        }) {
            Text("Done").modifier(ButtonModifier())
        }
    }
}

struct InfoSheet: View {
    @EnvironmentObject var user: User
    
    @Environment(\.dismiss) var dismiss
    
    var index: Int
    var dateFormat = DateFormatter()
    var timeFormat = DateFormatter()
    
    init(index: Int) {
        self.index = index
        dateFormat.dateStyle = .short
        timeFormat.timeStyle = .short
    }
    
    var body: some View {
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
                    Text(user.myServices[index].label)
                }
                
                Section(header: Text("Description").modifier(HeaderModifier())) {
                    Text(user.myServices[index].desc)
                }
   
                Section(header: Text("Address").modifier(HeaderModifier())) {
                    Text(user.myServices[index].address)
                }
                
                Section(header: Text("Date").modifier(HeaderModifier())) {
                    Text(dateFormat.string(from: user.myServices[index].date))
                }
                
                Section(header: Text("Time").modifier(HeaderModifier())) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Start")
                            Spacer()
                            Text(timeFormat.string(from: user.myServices[index].startTime))
                        }
                        
                        HStack {
                            Text("End")
                            Spacer()
                            Text(timeFormat.string(from: user.myServices[index].endTime))
                        }
                    }
                }
            }
        }
        .background(Color.CSUFBlue())
    }
}

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
//        AddServiceForm()
//                  .environmentObject(ServiceManager())
        ServiceView()
    }
}
