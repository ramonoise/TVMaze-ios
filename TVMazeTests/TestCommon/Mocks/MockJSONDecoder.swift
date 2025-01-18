import XCTest
@testable import TVMaze

final class MockJSONDecoder: JSONDecoderProtocol {
    var decodeResult: Any?
    var decodeError: Error?
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let error = decodeError {
            throw error
        }
        
        guard let result = decodeResult as? T else {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        
        return result
    }
}
