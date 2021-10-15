// MoviesUITests.swift
// Copyright © RM. All rights reserved.

import XCTest
/// UITests
class MoviesUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testTapOnCell() {
        let listPageTableView = application.tables["TableView"]
        listPageTableView.swipeUp(velocity: XCUIGestureVelocity.fast)
        let tapedCell = listPageTableView.cells.element(boundBy: 6)
        tapedCell.tap()
        let labelOnSecondScreen = application.staticTexts["Title"]
        XCTAssertTrue(!labelOnSecondScreen.label.isEmpty)
    }
}
