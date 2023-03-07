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



//    var weekDays: [String] = ["Вт", "Ср"]
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
//                                        Text(timeFormatter.string(from: alarm.time))
//                                        Text(alarm.time.formatted(.dateTime.minute().hour(.twoDigits(amPM: .omitted))))
                                            .font(.system(size: 60))

                                        Spacer()
                                        Toggle("Будильник включен", isOn: $alarm.isOn)
                                            .labelsHidden()
                                            .tint(.green)
                                    }

                                    HStack {
                                        if alarm.weekDays != [] {
                                            Text(alarm.alarmName == "" ? "Будильник," : "\(alarm.alarmName),")
                                            ForEach(alarm.weekDays, id: \.id) { day in
                                                Text(String(day.shortNameOfTheDay))
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
