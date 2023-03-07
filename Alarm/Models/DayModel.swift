//
//  DayModel.swift
//  Alarm
//
//  Created by Александр on 07.03.23.
//

import Foundation

struct Day: Identifiable, Equatable, Hashable {
    let id: Int
    var nameOfTheDay = ""
    var shortNameOfTheDay = ""
}
