import XCTest
@testable import TVMaze

class MockTVShowDataSource: TVShowDataSourceProtocol {
    var shouldReturnError = false
    var shouldReturnEmptyResults = false
    var shouldReturnErrorForShowDetail = false
    var mockedShows: [TVShow] = Stubs.tvShows
    var mockedShowDetail: TVShowDetail = Stubs.tvShowDetail
    
    var defaultError: Error {
        NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
    }

    required init(httpClient: HttpClientProtocol = MockHttpClient()) {}

    func fetchShows(page: Int) async throws -> [TVShow] {
        if shouldReturnError {
            throw defaultError
        }
        return shouldReturnEmptyResults ? [] : mockedShows
    }

    func fetchShowDetail(id: Int) async throws -> TVShowDetail {
        if shouldReturnErrorForShowDetail {
            throw defaultError
        }
        return mockedShowDetail
    }

    func fetchQuery(query: String, page: Int) async throws -> [TVShow] {
        if shouldReturnError {
            throw defaultError
        }
        return shouldReturnEmptyResults ? [] : mockedShows
    }
    
    enum Stubs {
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
}
