//
//  Copyright © 2020 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import HackrNews
import XCTest

final class NewStoriesPresentationTests: XCTestCase {
    func test_title_isLocalized() {
        XCTAssertEqual(NewStoriesPresenter.title, localized("new_stories_title"))
    }

    func test_init_doesNotSendMessagesToView() {
        let view = NewStoriesViewSpy()
        _ = NewStoriesPresenter(view: view)

        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages upon creation")
    }

    // MARK: - Helpers

    private func localized(_ key: String, file _: StaticString = #filePath, line _: UInt = #line) -> String {
        let table = "NewStories"
        let bundle = Bundle(for: NewStoriesPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if key == value {
            XCTFail("Missing localized string for key \(key) in table \(table)")
        }
        return value
    }

    private class NewStoriesViewSpy: NewStoriesView {
        var messages = [Any]()
    }
}
