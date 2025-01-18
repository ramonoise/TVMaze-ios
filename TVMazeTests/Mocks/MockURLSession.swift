import XCTest
@testable import TVMaze

final class MockURLSession: URLSessionProtocol {
    var dataResult: (Data, URLResponse)?
    var errorResult: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = errorResult {
            throw error
        }
        
        guard let result = dataResult else {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        
        return result
    }
}
