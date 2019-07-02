import Bond
import Aletheia
import Foundation
final class LLCalendarViewModel {
    let date = Observable<Date>(Date())
    func convert(from: Date) -> String {
        return from.al.stringType(format: "y 年 M 月 d 日")
    }
}
