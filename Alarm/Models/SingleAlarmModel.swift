//
//  SingleAlarmModel.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import Foundation

struct SingleAlarmModel: Identifiable {
    let id = UUID()
    var time = Date()
    var alarmName = ""
    var replayIsOn = true
    var isOn = true
    var weekDays = [Day]()
}
