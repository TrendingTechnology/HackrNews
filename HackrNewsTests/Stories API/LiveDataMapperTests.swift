//
//  Copyright © 2020 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import HackrNews
import XCTest

final class LiveDataMapperTests: XCTestCase {
    func test_map_throwsInvalidDataErrorOnNon200HTTPResponses() throws {
        let samples = [199, 201, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(try LiveDataMapper.map(data: anyData(), response: HTTPURLResponse(statusCode: code)))
        }
    }

    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSONData() {
        let invalidJSON = Data("invalid json".utf8)

        XCTAssertThrowsError(try LiveDataMapper.map(data: invalidJSON, response: HTTPURLResponse(statusCode: 200)))
    }

    func test_map_deliversLiveItemsOn200HTTPResponseWithValidJSONData() throws {
        let items = [10, 20, 30]
        let validJSON = makeItems(items: items)

        let liveItems = try LiveDataMapper.map(data: validJSON, response: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(liveItems.map(\.id), items)
    }

    // MARK: - Helpers

    private func makeItems(items: [Int] = []) -> Data {
        try! JSONSerialization.data(withJSONObject: items)
    }
}
