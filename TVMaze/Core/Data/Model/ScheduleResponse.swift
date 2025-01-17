import Foundation

struct ScheduleResponse: Decodable {
    let time: String
    let days: [String]
}
