import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    func formattedDay() -> String {
        formatted(date: .abbreviated, time: .omitted)
    }

    func formattedTime() -> String {
        formatted(date: .omitted, time: .shortened)
    }
}
