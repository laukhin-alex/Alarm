//
//  AlarmView.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI

struct AlarmView: View {
    @State private var presentingSingleAlarm = false
    @EnvironmentObject var alarmVM: AlarmViewModel

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea(.all)
                VStack {
                    VStack {
                        HStack{
                            Image(systemName: "bed.double.fill")
                            Text("Сон | Пробуждение")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.vertical)
                        HStack {
                            Text("Нет будильника")
                                .foregroundColor(.gray)
                            Spacer()
                            Button("НАСТРОИТЬ") {}
                                .buttonStyle(.bordered)
                                .controlSize(.mini)
                        }
                        HStack{
                            Text("Другие")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                    VStack {
                        List {
                            ForEach($alarmVM.alarms) { $alarm in
                                VStack {
                                    HStack {
                                        Text(alarmVM.timeFormatter.string(from: alarm.time))
                                            .font(.system(size: 60))
                                        Spacer()
                                        Toggle("Будильник включен", isOn: $alarm.isOn)
                                            .labelsHidden()
                                            .tint(.green)
                                    }
                                    HStack {
                                        if alarm.weekDays != [] {
                                            Text(alarm.alarmName == "" ? "Будильник," : "\(alarm.alarmName),")
                                            if alarm.weekDays.count == 1 {
                                                ForEach(alarm.weekDays, id: \.id) { day in
                                                    Text(day.nameOfTheDay)
                                                }
                                            } else if alarm.weekDays.count == 7 {
                                                Text("Каждый день")
                                            } else if (
                                                alarm.weekDays.contains { $0.id != 1 } &&
                                                alarm.weekDays.contains { $0.id != 2 } &&
                                                alarm.weekDays.contains { $0.id != 3 } &&
                                                alarm.weekDays.contains { $0.id != 4 } &&
                                                alarm.weekDays.contains { $0.id != 5 } &&
                                                alarm.weekDays.contains { $0.id == 6 } &&
                                                alarm.weekDays.contains { $0.id == 7 } &&
                                                alarm.weekDays.count == 2
                                            ) {
                                                Text("Выходные")
                                            } else if (
                                                alarm.weekDays.contains { $0.id == 1 } &&
                                                alarm.weekDays.contains { $0.id == 2 } &&
                                                alarm.weekDays.contains { $0.id == 3 } &&
                                                alarm.weekDays.contains { $0.id == 4 } &&
                                                alarm.weekDays.contains { $0.id == 5 } &&
                                                alarm.weekDays.contains { $0.id != 6 } &&
                                                alarm.weekDays.contains { $0.id != 7 } &&
                                                alarm.weekDays.count == 5
                                            ) {
                                                Text("Будние дни")
                                            } else if alarm.weekDays.count > 1 {
                                                ForEach(alarm.weekDays, id: \.id) { day in
                                                    Text(day.shortNameOfTheDay)
                                                }
                                            }
                                            Spacer()
                                        } else {
                                            Text(alarm.alarmName == "" ? "Будильник" : "\(alarm.alarmName)")
                                            Spacer()
                                        }
                                    }
                                }
                                .foregroundColor(alarm.isOn ? .white : .gray)
                                    .listRowSeparatorTint(.white)
                            }
                            .onDelete { offsets in
                                alarmVM.alarms.remove(atOffsets: offsets)
                            }
                            .listRowBackground(Color.black)

                        }
                        .listStyle(.grouped)
                        .scrollContentBackground(.hidden)
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $presentingSingleAlarm) {
                SingleAlarmAddingView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentingSingleAlarm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .tint(.orange)
            .navigationTitle("Будильник")
        }
        .onAppear {
            alarmVM.tabBarPreferences()
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
            .environmentObject(AlarmViewModel())
    }
}
