import Foundation

protocol TVShowDataSourceProtocol {
    init(httpClient: HttpClient)
    
    func fetchShows(page: Int) async throws -> [TVShowItem]
    func fetchQuery(query:String, page: Int) async throws -> [TVShowItem]
}

final class TVShowDataSource: TVShowDataSourceProtocol {
    private var httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchShows(page: Int) async throws -> [TVShowItem] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows?page=:page",
                   replacingParameters: ["page": String(page)])
        return try await httpClient.request(urlString: url)
    }
    
    func fetchQuery(query: String, page: Int) async throws -> [TVShowItem] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows?q=:query&page=:page",
                   replacingParameters: ["query": query,
                                         "page": String(page)])
        return try await httpClient.request(urlString: url)
    }
}
