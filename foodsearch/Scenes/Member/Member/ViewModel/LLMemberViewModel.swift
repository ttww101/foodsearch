import Bond
import Foundation
import ReactiveKit
final class LLMemberViewModel {
    private let password = Observable<String?>("")
    private let phone = Observable<String?>("")
    init() {}
    func getViewData() -> [LLMemberFormModel] {
        return [
            LLMemberFormModel(imageName: nil,
                              title: "姓名",
                              text: LLUserManager.share.infos?.name),
            LLMemberFormModel(imageName: nil,
                              title: "手機",
                              text: LLUserManager.share.infos?.mobile),
            LLMemberFormModel(imageName: "icon_calendar",
                              title: "信箱",
                              text: LLUserManager.share.infos?.email),
            LLMemberFormModel(imageName: "icon_calendar",
                              title: "密碼",
                              text: "**********")
        ]
    }
}
