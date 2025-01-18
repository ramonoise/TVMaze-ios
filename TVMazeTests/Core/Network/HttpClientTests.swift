import XCTest
@testable import TVMaze

class HttpClientTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var mockJSONDecoder: MockJSONDecoder!
    var httpClient: HttpClient!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        mockJSONDecoder = MockJSONDecoder()
        httpClient = HttpClient(urlSession: mockURLSession, decoder: mockJSONDecoder)
    }
    
    override func tearDown() {
        mockURLSession = nil
        mockJSONDecoder = nil
        httpClient = nil
        super.tearDown()
    }
    
    func testValidRequestSucceeds() async {
        httpClient = HttpClient(urlSession: mockURLSession, decoder: JSONDecoder())
        let expectedData = """
        {
            "id": "1",
            "name": "Test Show"
        }
        """.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockURLSession.mockData = expectedData
        mockURLSession.mockURLResponse = mockResponse
        mockURLSession.mockError = nil
        do {
            let response: [String: String] = try await httpClient.request(urlString: "https://example.com", method: .get)
            XCTAssertEqual(response["id"], "1")
            XCTAssertEqual(response["name"], "Test Show")
        } catch {
            XCTFail("Request failed with error: \(error)")
        }
    }
    
    func testInvalidURL() async {
        mockURLSession.mockError = nil
        do {
            let _: [String: String] = try await httpClient.request(urlString: "")
            XCTFail("Expected invalidURL error, but request succeeded")
        } catch let error as HttpClientError {
            XCTAssertEqual(error, HttpClientError.invalidURL)
        } catch {
            XCTFail("Expected HttpClientError.invalidURL, but got \(error)")
        }
    }
    
    func testInvalidResponse() async {
        let mockResponse = URLResponse()
        mockURLSession.mockData = Data()
        mockURLSession.mockURLResponse = mockResponse
        do {
            let _: [String: String] = try await httpClient.request(urlString: "https://example.com")
            XCTFail("Expected invalidResponse error, but request succeeded")
        } catch let error as HttpClientError {
            XCTAssertEqual(error, HttpClientError.invalidResponse(data: Data(), urlResponse: mockResponse))
        } catch {
            XCTFail("Expected HttpClientError.invalidResponse, but got \(error)")
        }
    }
    
    func testInvalidStatusCode() async {
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        mockURLSession.mockData = Data()
        mockURLSession.mockURLResponse = mockResponse
        do {
            let _: [String: String] = try await httpClient.request(urlString: "https://example.com")
            XCTFail("Expected invalidStatusCode error, but request succeeded")
        } catch let error as HttpClientError {
            XCTAssertEqual(error, HttpClientError.invalidStatusCode(data: Data(), httpResponse: mockResponse))
        } catch {
            XCTFail("Expected HttpClientError.invalidStatusCode, but got \(error)")
        }
    }
    
    func testJSONDecodingError() async {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        mockURLSession.mockData = invalidData
        mockJSONDecoder.decodeError = DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Corrupted data"))
        do {
            let _: [String: String] = try await httpClient.request(urlString: "https://example.com")
            XCTFail("Expected decoding error, but request succeeded")
        } catch let error as DecodingError {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        } catch {
            XCTFail("Expected DecodingError, but got \(error)")
        }
    }
}
