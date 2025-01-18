import XCTest
@testable import TVMaze

final class MockHttpClient: HttpClientProtocol {
    var urlSession: URLSessionProtocol
    var mockUrlSession: MockURLSession!
    
    var decoder: JSONDecoderProtocol
    var mockDecoder: MockJSONDecoder!
    
    var requestResult: Any?
    var errorResult: Error?
    
    required init(urlSession: URLSessionProtocol = MockURLSession(),
                  decoder: JSONDecoderProtocol = MockJSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    init() {
        var urlSession = MockURLSession()
        var decoder = MockJSONDecoder()
        
        self.urlSession = urlSession
        self.mockUrlSession = urlSession
        
        self.decoder = decoder
        self.mockDecoder = decoder
    }
    
    func request<T>(urlString: String, method: HttpMethod) async throws -> T where T : Decodable {
        if let error = errorResult {
            throw error
        }
        
        guard let result = requestResult as? T else {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        
        return result
    }
}

