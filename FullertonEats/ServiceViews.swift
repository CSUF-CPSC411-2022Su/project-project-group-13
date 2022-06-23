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

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(self.user.myServices.enumerated()), id: \.1) { index, service in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(service.label)
                            
                            Text(service.address)
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        editServiceButton
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
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton
                }
            }

        }.environmentObject(user)
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
            Image(systemName: "info.circle")
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
            }.padding(.vertical, 10)
            
            List {
                labelSection
                descSection
                addressSection
                dateSection
                timeSection
            }
            .listStyle(InsetGroupedListStyle())
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
            }.padding(.vertical, 10)
            
            List {
                labelSection
                descSection
                addressSection
                dateSection
                timeSection
            }
            .listStyle(InsetGroupedListStyle())
        }
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

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
//        AddServiceForm()
//                  .environmentObject(ServiceManager())
        ServiceView()
    }
}