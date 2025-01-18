import XCTest
@testable import TVMaze

private enum Stubs {
    static var tvShows = [
        TVShow(id: 1, name: "Show Name #1", image: .dummy()),
        TVShow(id: 2, name: "Show Name #2", image: .dummy())
    ]
    
    static var tvShowDetail = TVShowDetail(
        id: 1,
        name: "Show Name #1",
        image: .dummy(),
        genres: ["Drama", "Comedy"],
        schedule: .init(time: "21:00", days: ["Sunday"]),
        summary: "Show 1 Summary",
        episodes: [
            TVShowEpisode(id: 101,
                          name: "Pilot",
                          number: 1,
                          season: 1,
                          summary: "Episode 1 Summary",
                          image: .dummy()),
            TVShowEpisode(id: 102,
                          name: "GoGo",
                          number: 2,
                          season: 1,
                          summary: "Episode 2 Summary",
                          image: .dummy())
        ])
}

final class MockTVShowDataSource: TVShowDataSourceProtocol {
    var httpClient: HttpClientProtocol
    var mockHttpClient: MockHttpClient!
    var fetchShowsResult: Result<[TVShow], Error>? = .success(Stubs.tvShows)
    var fetchShowDetailResult: Result<TVShowDetail, Error>? = .success(Stubs.tvShowDetail)
    var fetchQueryResult: Result<[TVShow], Error>? = .success(Stubs.tvShows)
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    init() {
        let mockHttpClient = MockHttpClient()
        self.httpClient = mockHttpClient
        self.mockHttpClient = mockHttpClient
    }
    
    func fetchShows(page: Int) async throws -> [TVShow] {
        if let result = fetchShowsResult {
            switch result {
                case .success(let shows):
                    return shows
                case .failure(let error):
                    throw error
            }
        }
        return []
    }
    
    func fetchShowDetail(id: Int) async throws -> TVShowDetail {
        if let result = fetchShowDetailResult {
            switch result {
                case .success(let showDetail):
                    return showDetail
                case .failure(let error):
                    throw error
            }
        }
        throw NSError(domain: "MockError", code: -1, userInfo: nil)
    }
    
    func fetchQuery(query: String, page: Int) async throws -> [TVShow] {
        if let result = fetchQueryResult {
            switch result {
                case .success(let shows):
                    return shows
                case .failure(let error):
                    throw error
            }
        }
        return []
    }
}
