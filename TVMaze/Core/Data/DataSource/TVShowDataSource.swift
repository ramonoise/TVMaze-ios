import Foundation

protocol TVShowDataSourceProtocol {
    init(httpClient: HttpClient)
    
    func fetchShows(page: Int) async throws -> [TVShow]
    func fetchShowDetail(id: Int) async throws -> TVShowDetail
    func fetchQuery(query:String, page: Int) async throws -> [TVShow]
}

final class TVShowDataSource: TVShowDataSourceProtocol {
    private var httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClient()) {
        self.httpClient = httpClient
    }
    
    func fetchShowDetail(id: Int) async throws -> TVShowDetail {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows/:id?embed=episodes",
                   replacingParameters: ["id" : String(id)])
        
        let response: TVShowDetailResponse = try await httpClient.request(urlString: url)
        return response.toDomain()
    }
    
    func fetchShows(page: Int) async throws -> [TVShow] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/shows?page=:page",
                   replacingParameters: ["page": String(page)])
        
        let response: [TVShowResponse] = try await httpClient.request(urlString: url)
        return response.compactMap { $0.toDomain() }
    }
    
    func fetchQuery(query: String, page: Int) async throws -> [TVShow] {
        let url = URLStringBuilder
            .build(url: "https://api.tvmaze.com/search/shows?q=:query&page=:page",
                   replacingParameters: ["query": query,
                                         "page": String(page)])
        debugPrint(url)
        let response: [TVSearchShowResponse] = try await httpClient.request(urlString: url)
        debugPrint(response)
        return response.compactMap { $0.toDomain() }
    }
}
