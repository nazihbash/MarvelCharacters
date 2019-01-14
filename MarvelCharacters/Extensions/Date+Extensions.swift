import Foundation

extension Date {
    
    public func differenceInDaysFromNow() -> Int {
        let date1 = Calendar.current.startOfDay(for: Date())
        let date2 = Calendar.current.startOfDay(for: self)
        if let diff = Calendar.current.dateComponents([.day], from: date1, to: date2).day {
            return diff
        }
        return -1
    }
}
