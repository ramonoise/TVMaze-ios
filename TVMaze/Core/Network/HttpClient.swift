import Foundation

// MARK: Enums
enum HttpMethod: String, RawRepresentable {
    case get = "GET"
}

enum HttpClientError: Error {
    case invalidURL
    case invalidResponse(data: Data, urlResponse: URLResponse)
    case invalidStatusCode(data: Data, httpResponse: HTTPURLResponse)
}

// MARK: Protocols
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

protocol JSONDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

protocol HttpClientProtocol {
    init(urlSession: URLSessionProtocol, decoder: JSONDecoderProtocol)
    
    func request<T>(urlString: String, method: HttpMethod) async throws -> T where T : Decodable
}

// MARK: Implementation
struct HttpClient: HttpClientProtocol {
    private(set) var urlSession: URLSessionProtocol
    private(set) var decoder: JSONDecoderProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared, decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func request<T>(urlString: String, method: HttpMethod = .get) async throws -> T where T : Decodable {
        guard let url = URL(string: urlString) else {
            throw HttpClientError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let (data, urlResponse) = try await urlSession.data(for: request)
        
        // Checking if the response is valid
        guard let httpResponse = (urlResponse as? HTTPURLResponse) else {
            throw HttpClientError.invalidResponse(data: data, urlResponse: urlResponse)
        }
        
        // Checking if the status code is valid
        guard (200...299).contains(httpResponse.statusCode) else {
            throw HttpClientError.invalidStatusCode(data: data, httpResponse: httpResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: Extensions
extension URLSession: URLSessionProtocol { }
extension JSONDecoder: JSONDecoderProtocol { }
extension HttpClientProtocol {
    func request<T>(urlString: String) async throws -> T where T : Decodable {
        try await request(urlString: urlString, method: .get)
    }
}
