import XCTest
@testable import TVMaze

final class TVShowDetailResponseTests: XCTestCase {
    
    func testTVShowDetailResponseDecoding() throws {
        let jsonData = """
        {
            "id": 1,
            "name": "Test Show",
            "image": {
                "medium": "https://example.com/medium.jpg",
                "original": "https://example.com/original.jpg"
            },
            "genres": ["Drama", "Thriller"],
            "schedule": {
                "time": "20:00",
                "days": ["Monday", "Thursday"]
            },
            "summary": "A test show summary.",
            "_embedded": {
                "episodes": [
                    {
                        "id": 101,
                        "name": "Pilot",
                        "season": 1,
                        "number": 1,
                        "summary": "Lorem Ipsum",
                        "image": {
                            "medium": "https://example.com/episode/medium.jpg",
                            "original": "https://example.com/episode/original.jpg"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        let decodedResponse = try JSONDecoder().decode(TVShowDetailResponse.self, from: jsonData)
        
        XCTAssertEqual(decodedResponse.id, 1)
        XCTAssertEqual(decodedResponse.name, "Test Show")
        XCTAssertEqual(decodedResponse.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(decodedResponse.image.originalURL, "https://example.com/original.jpg")
        XCTAssertEqual(decodedResponse.genres, ["Drama", "Thriller"])
        XCTAssertEqual(decodedResponse.schedule.time, "20:00")
        XCTAssertEqual(decodedResponse.schedule.days, ["Monday", "Thursday"])
        XCTAssertEqual(decodedResponse.summary, "A test show summary.")
        XCTAssertEqual(decodedResponse.episodes.count, 1)
        XCTAssertEqual(decodedResponse.episodes.first!.id, 101)
        XCTAssertEqual(decodedResponse.episodes.first!.name, "Pilot")
        XCTAssertEqual(decodedResponse.episodes.first!.summary, "Lorem Ipsum")
        XCTAssertEqual(decodedResponse.episodes.first!.image!.mediumURL, "https://example.com/episode/medium.jpg")
        XCTAssertEqual(decodedResponse.episodes.first!.image!.originalURL, "https://example.com/episode/original.jpg")
    }
    
    func testTVShowDetailResponseToDomain() throws {
        let response = TVShowDetailResponse(
            id: 1,
            name: "Test Show",
            image: .init(mediumURL: "https://example.com/medium.jpg", originalURL: "https://example.com/original.jpg"),
            genres: ["Drama", "Thriller"],
            schedule: .init(time: "20:00", days: ["Monday", "Thursday"]),
            summary: "A test show summary.",
            episodes: [
                .init(
                    id: 101,
                    name: "Pilot",
                    season: 1,
                    number: 1,
                    summary: "Lorem Ipsum",
                    image: .init(mediumURL: "https://example.com/episode/medium.jpg", 
                                 originalURL: "https://example.com/episode/original.jpg")
                )
            ]
        )
        
        let domainModel = response.toDomain()
        
        XCTAssertEqual(domainModel.id, 1)
        XCTAssertEqual(domainModel.name, "Test Show")
        XCTAssertEqual(domainModel.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(domainModel.image.originalURL, "https://example.com/original.jpg")
        XCTAssertEqual(domainModel.genres, ["Drama", "Thriller"])
        XCTAssertEqual(domainModel.schedule.time, "20:00")
        XCTAssertEqual(domainModel.schedule.days, ["Monday", "Thursday"])
        XCTAssertEqual(domainModel.summary, "A test show summary.")
        XCTAssertEqual(domainModel.episodes.count, 1)
        XCTAssertEqual(domainModel.episodes.first!.id, 101)
        XCTAssertEqual(domainModel.episodes.first!.name, "Pilot")
        XCTAssertEqual(domainModel.episodes.first!.summary, "Lorem Ipsum")
        XCTAssertEqual(domainModel.episodes.first!.image!.mediumURL, "https://example.com/episode/medium.jpg")
        XCTAssertEqual(domainModel.episodes.first!.image!.originalURL, "https://example.com/episode/original.jpg")
    }
}
