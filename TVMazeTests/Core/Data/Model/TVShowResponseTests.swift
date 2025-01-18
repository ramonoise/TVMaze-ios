import XCTest
@testable import TVMaze

final class TVShowResponseTests: XCTestCase {
    
    func testTVShowResponseDecoding() throws {
        let jsonData = """
        {
            "id": 1,
            "name": "Test Show",
            "image": {
                "medium": "https://example.com/medium.jpg",
                "original": "https://example.com/original.jpg"
            }
        }
        """.data(using: .utf8)!
        
        let decodedResponse = try JSONDecoder().decode(TVShowResponse.self, from: jsonData)
        
        XCTAssertEqual(decodedResponse.id, 1)
        XCTAssertEqual(decodedResponse.name, "Test Show")
        XCTAssertEqual(decodedResponse.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(decodedResponse.image.originalURL, "https://example.com/original.jpg")
    }
    
    func testTVShowResponseToDomain() throws {
        let response = TVShowResponse(
            id: 1,
            name: "Test Show",
            image: .init(mediumURL: "https://example.com/medium.jpg", originalURL: "https://example.com/original.jpg")
        )
        
        let domainModel = response.toDomain()
        
        XCTAssertEqual(domainModel.id, 1)
        XCTAssertEqual(domainModel.name, "Test Show")
        XCTAssertEqual(domainModel.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(domainModel.image.originalURL, "https://example.com/original.jpg")
    }
    
    func testTVSearchShowResponseDecoding() throws {
        let jsonData = """
        {
            "show": {
                "id": 1,
                "name": "Test Show",
                "image": {
                    "medium": "https://example.com/medium.jpg",
                    "original": "https://example.com/original.jpg"
                }
            }
        }
        """.data(using: .utf8)!
        
        let decodedResponse = try JSONDecoder().decode(TVSearchShowResponse.self, from: jsonData)
        
        XCTAssertEqual(decodedResponse.show.id, 1)
        XCTAssertEqual(decodedResponse.show.name, "Test Show")
        XCTAssertEqual(decodedResponse.show.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(decodedResponse.show.image.originalURL, "https://example.com/original.jpg")
    }
    
    func testTVSearchShowResponseToDomain() throws {
        let response = TVSearchShowResponse(
            show: .init(
                id: 1,
                name: "Test Show",
                image: .init(mediumURL: "https://example.com/medium.jpg", originalURL: "https://example.com/original.jpg")
            )
        )
        
        let domainModel = response.toDomain()
        
        XCTAssertEqual(domainModel.id, 1)
        XCTAssertEqual(domainModel.name, "Test Show")
        XCTAssertEqual(domainModel.image.mediumURL, "https://example.com/medium.jpg")
        XCTAssertEqual(domainModel.image.originalURL, "https://example.com/original.jpg")
    }
}
