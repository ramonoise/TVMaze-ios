import XCTest
@testable import TVMaze

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockURLResponse: URLResponse?
    var mockError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        return (mockData ?? Data(), mockURLResponse ?? HTTPURLResponse())
    }
}
