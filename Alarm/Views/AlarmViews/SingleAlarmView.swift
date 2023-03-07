//
//  SingleAlarmView.swift
//  Alarm
//
//  Created by Александр on 06.03.23.
//

import SwiftUI

struct SingleAlarmView: View {
    @State private var isOn = true
    var alarmName: String = "Будильник"
    var weekDays: [String] = []
    var time: Date

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text(Date().formatted(.dateTime.minute().hour(.twoDigits(amPM: .omitted))))
                        .font(.system(size: 60))

                    Spacer()
                    Toggle("Будильник включен", isOn: $isOn)
                        .labelsHidden()
                }

                HStack {
                    if weekDays != [] {
                        Text("\(alarmName),")
                        ForEach(weekDays, id: \.self) { day in
                            Text(day.description)
                        }
                        Spacer()
                    } else {
                        Text(alarmName)
                        Spacer()
                    }
                }
            }
            .background(Color.red)
            .foregroundColor(isOn ? .white : .gray)

        }
    }
}

struct SingleAlarmVIew_Previews: PreviewProvider {
    static var previews: some View {
        SingleAlarmView(alarmName: "Будильник", weekDays: ["Вт", "Чт"], time: Date())
    }
}
