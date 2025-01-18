import XCTest
@testable import TVMaze

final class EpisodeResponseTests: XCTestCase {
    
    func testEpisodeResponseDecoding() throws {
        let jsonData = """
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
        """.data(using: .utf8)!
        
        let decodedResponse = try JSONDecoder().decode(EpisodeResponse.self, from: jsonData)
        
        XCTAssertEqual(decodedResponse.id, 101)
        XCTAssertEqual(decodedResponse.name, "Pilot")
        XCTAssertEqual(decodedResponse.season, 1)
        XCTAssertEqual(decodedResponse.number, 1)
        XCTAssertEqual(decodedResponse.summary, "Lorem Ipsum")
        XCTAssertEqual(decodedResponse.image?.mediumURL, "https://example.com/episode/medium.jpg")
        XCTAssertEqual(decodedResponse.image?.originalURL, "https://example.com/episode/original.jpg")
    }
    
    func testEpisodeResponseDecodingWithoutImage() throws {
        let jsonData = """
        {
            "id": 102,
            "name": "Episode 2",
            "season": 1,
            "number": 2,
            "summary": "Another episode.",
            "image": null
        }
        """.data(using: .utf8)!
        
        let decodedResponse = try JSONDecoder().decode(EpisodeResponse.self, from: jsonData)
        
        XCTAssertEqual(decodedResponse.id, 102)
        XCTAssertEqual(decodedResponse.name, "Episode 2")
        XCTAssertEqual(decodedResponse.season, 1)
        XCTAssertEqual(decodedResponse.number, 2)
        XCTAssertEqual(decodedResponse.summary, "Another episode.")
        XCTAssertNil(decodedResponse.image)
    }
    
    func testEpisodeResponseToDomain() throws {
        let response = EpisodeResponse(
            id: 101,
            name: "Pilot",
            season: 1,
            number: 1,
            summary: "Lorem Ipsum",
            image: .init(mediumURL: "https://example.com/episode/medium.jpg", originalURL: "https://example.com/episode/original.jpg")
        )
        
        let domainModel = response.toDomain()
        
        XCTAssertEqual(domainModel.id, 101)
        XCTAssertEqual(domainModel.name, "Pilot")
        XCTAssertEqual(domainModel.season, 1)
        XCTAssertEqual(domainModel.number, 1)
        XCTAssertEqual(domainModel.summary, "Lorem Ipsum")
        XCTAssertNotNil(domainModel.image)
        XCTAssertEqual(domainModel.image?.mediumURL, "https://example.com/episode/medium.jpg")
        XCTAssertEqual(domainModel.image?.originalURL, "https://example.com/episode/original.jpg")
    }
    
    func testEpisodeResponseToDomainWithoutImage() throws {
        let response = EpisodeResponse(
            id: 102,
            name: "Episode 2",
            season: 1,
            number: 2,
            summary: "Another episode.",
            image: nil
        )
        
        let domainModel = response.toDomain()
        
        XCTAssertEqual(domainModel.id, 102)
        XCTAssertEqual(domainModel.name, "Episode 2")
        XCTAssertEqual(domainModel.season, 1)
        XCTAssertEqual(domainModel.number, 2)
        XCTAssertEqual(domainModel.summary, "Another episode.")
        XCTAssertNil(domainModel.image)
    }
}
