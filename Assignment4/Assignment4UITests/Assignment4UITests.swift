//
//  Assignment4UITests.swift
//  Assignment4UITests
//
<<<<<<< HEAD
//  Created by Yash Vipul Naik on 2025-04-04.
=======
//  Created by Yash on 2025-04-06.
>>>>>>> 480ace2773d13c5070af29e2ef21cae5f60418fc
//

import XCTest

<<<<<<< HEAD
final class Assignment4UITests: XCTestCase {
=======
class Assignment4UITests: XCTestCase {
>>>>>>> 480ace2773d13c5070af29e2ef21cae5f60418fc

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

<<<<<<< HEAD
=======
        // Use recording to get started writing UI tests.
>>>>>>> 480ace2773d13c5070af29e2ef21cae5f60418fc
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
