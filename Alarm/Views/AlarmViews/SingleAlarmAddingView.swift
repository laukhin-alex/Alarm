//
//  SingleAlarmAddingView.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI

struct SingleAlarmAddingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var alarmVM: AlarmViewModel
    @State var time = Date()
    @State var replayIsOn = true
    @State var isOn = true
    @State var alarmName = ""
    let melody = ["din don", "ring", "alarm"]
    @State var selectedMelody: String? = nil

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.9)
                    .ignoresSafeArea(.all)
                VStack {
                    DatePicker("Alarm", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .colorInvert()
                        .labelsHidden()
                    Form {
                        Section {
                            NavigationLink {
                                ReplayView()
                            } label: {
                                HStack {
                                    Text("Повтор")
                                    Spacer()
                                    HStack {
                                        if alarmVM.selectedDays == [] {
                                            Text("Никогда")
                                        } else {
                                            if alarmVM.selectedDays.count == 1 {
                                                ForEach(alarmVM.sortedSelectedDays, id: \.self) { day in
                                                    Text(day.nameOfTheDay)
                                                }
                                            } else if alarmVM.selectedDays.count == 7 {
                                                Text("Каждый день")
                                            } else if (
                                                alarmVM.selectedDays.contains { $0.id != 1 } &&
                                                alarmVM.selectedDays.contains { $0.id != 2 } &&
                                                alarmVM.selectedDays.contains { $0.id != 3 } &&
                                                alarmVM.selectedDays.contains { $0.id != 4 } &&
                                                alarmVM.selectedDays.contains { $0.id != 5 } &&
                                                alarmVM.selectedDays.contains { $0.id == 6 } &&
                                                alarmVM.selectedDays.contains { $0.id == 7 } &&
                                                alarmVM.selectedDays.count == 2
                                            ) {
                                                Text("Выходные")
                                            } else if (
                                                alarmVM.selectedDays.contains { $0.id == 1 } &&
                                                alarmVM.selectedDays.contains { $0.id == 2 } &&
                                                alarmVM.selectedDays.contains { $0.id == 3 } &&
                                                alarmVM.selectedDays.contains { $0.id == 4 } &&
                                                alarmVM.selectedDays.contains { $0.id == 5 } &&
                                                alarmVM.selectedDays.contains { $0.id != 6 } &&
                                                alarmVM.selectedDays.contains { $0.id != 7 } &&
                                                alarmVM.selectedDays.count == 5
                                            ) {
                                                Text("Будние дни")
                                            } else if alarmVM.selectedDays.count > 1 {
                                                ForEach(alarmVM.sortedSelectedDays, id: \.self) { day in
                                                    Text(day.shortNameOfTheDay)
                                                }
                                            }
                                        }
                                    }
                                    .foregroundColor(.gray)
                                }
                            }
                            HStack {
                                Text("Название")
                                Spacer()
                                TextField("Будильник", text: $alarmName)
                                    .keyboardType(.default)
                                    .multilineTextAlignment(.trailing)
                            }
                            NavigationLink {
                                MelodyViews()
                            } label: {
                                HStack {
                                    Text("Мелодия")
                                    Spacer()
                                    Text(alarmVM.selectedMelody?.description ?? "ring")
                                        .foregroundColor(.gray)
                                }
                            }
                            Toggle("Повторение сигнала", isOn: $replayIsOn)
                                .tint(.green)
                        }
                        .foregroundColor(.white)
                        .listRowBackground(Color.gray.opacity(0.1))
                        .scrollContentBackground(.hidden)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        alarmVM.clearData()
                        dismiss()
                    }) {
                        Text("Отменить")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        alarmVM.alarms.append(SingleAlarmModel(time: time, alarmName: alarmName, replayIsOn: replayIsOn, isOn: isOn, weekDays: alarmVM.sortedSelectedDays))
                        print(alarmVM.alarms)
                        alarmVM.clearData()
                        dismiss()
                    }) {
                        Text("Сохранить")
                    }
                }
            }
            .tint(.orange)
            .scrollContentBackground(.hidden)
            .navigationTitle("Будильник")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct SingleAlarmAddingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAlarmAddingView()
            .environmentObject(AlarmViewModel())
    }
}
