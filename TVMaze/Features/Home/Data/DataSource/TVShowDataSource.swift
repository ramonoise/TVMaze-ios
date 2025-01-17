import Foundation

protocol TVShowDataSourceProtocol {
    init(httpClient: HttpClient)
    
    func fetchShows(page: Int) async throws -> [TVShow]
    func fetchQuery(query:String, page: Int) async throws -> [TVShow]
}

final class TVShowDataSource: TVShowDataSourceProtocol {
    private var httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func fetchShows(page: Int) async throws -> [TVShow] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows?page=:page",
                   replacingParameters: ["page": String(page)])
        
        let response: [TVShowItemResponse] = try await httpClient.request(urlString: url)
        return response.map { $0.toDomain() }
    }
    
    func fetchQuery(query: String, page: Int) async throws -> [TVShow] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows?q=:query&page=:page",
                   replacingParameters: ["query": query,
                                         "page": String(page)])
        let response: [TVShowItemResponse] = try await httpClient.request(urlString: url)
        return response.map { $0.toDomain() }
    }
}
