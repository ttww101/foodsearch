import UIKit
import SnapKit
import Aletheia
import JTAppleCalendar
final class LLCalendarView: JTAppleCalendarView {
    var actionClick: ((_ date: Date) -> ())?
    private let identifier: String = "identifier"
    private let identifierHeader: String = "headerIdentifier"
    private let startDate: Date
    private let endDate: Date
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M 月"
        f.timeZone = Calendar.current.timeZone
        f.locale = Calendar.current.locale
        return f
    }()
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        super.init()
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        register(LLCalendarCell.self,
                 forCellWithReuseIdentifier: identifier)
        register(LLCalendarHeaderView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: identifierHeader)
        calendarDataSource  = self
        calendarDelegate    = self
        scrollDirection     = .horizontal
        scrollingMode       = .stopAtEachCalendarFrame
        backgroundColor     = .white
        minimumInteritemSpacing = 0.0
        minimumLineSpacing      = 0.0
    }
}
extension LLCalendarView {
    private func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? LLCalendarCell  else { return }
        cell.context.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    private func handleCellTextColor(cell: LLCalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
    }
    private func handleCellSelected(cell: LLCalendarCell, cellState: CellState) {
        cell.context.textColor = cellState.isSelected ? .white : .black
        cell.selectedView.isHidden = !cellState.isSelected
        if cellState.isSelected {
            let halfWidth = cell.selectedView.frame.width / 2
            cell.selectedView.layer.cornerRadius = halfWidth
            actionClick?(cellState.date)
        }
    }
}
extension LLCalendarView: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid)
    }
}
extension LLCalendarView: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView,
                  cellForItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: identifier, for: indexPath) as! LLCalendarCell
        self.calendar(calendar,
                      willDisplay: cell,
                      forItemAt: date,
                      cellState: cellState,
                      indexPath: indexPath)
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return true
    }
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(
            withReuseIdentifier: identifierHeader,
                            for: indexPath) as! LLCalendarHeaderView
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}
