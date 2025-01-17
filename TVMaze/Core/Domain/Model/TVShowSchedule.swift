import Foundation

struct TVShowSchedule: Decodable, Hashable {
    let time: String
    let days: [String]
}
