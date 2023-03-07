//
//  AlarmViewModel.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI
// MARK: - разобраться с форматом данных

final class AlarmViewModel: ObservableObject {
    @Published var alarms: [SingleAlarmModel] = []
    @Published var selectedDays = [Day]()
    var sortedSelectedDays: [Day] {
        get {
            selectedDays.sorted(by: { $0.id < $1.id })
        }
        set {
            selectedDays = newValue
        }
    }
    @Published var weekDays = [Day]()
//    @Published var dayNames = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
//    @Published var dayNamesShort = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    var melody = ["din don", "ring", "alarm"]
    @Published var selectedMelody: String? = "ring"

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }



    init() {
        weekDays = [
            Day(id: 1, nameOfTheDay: "Каждый понедельник", shortNameOfTheDay: "Пн"),
            Day(id: 2, nameOfTheDay: "Каждый вторник", shortNameOfTheDay: "Вт"),
            Day(id: 3, nameOfTheDay: "Каждую среду", shortNameOfTheDay: "Ср"),
            Day(id: 4, nameOfTheDay: "Каждый четверг", shortNameOfTheDay: "Чт"),
            Day(id: 5, nameOfTheDay: "Каждую пятницу", shortNameOfTheDay: "Пт"),
            Day(id: 6, nameOfTheDay: "Каждую субботу", shortNameOfTheDay: "Сб"),
            Day(id: 7, nameOfTheDay: "Каждое воскресенье", shortNameOfTheDay: "Вс")
        ]
    }

    func clearData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            selectedDays.removeAll()
            selectedMelody = "ring"
        }
    }

    func tabBarPreferences() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color.black)
        UITabBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.black)
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
