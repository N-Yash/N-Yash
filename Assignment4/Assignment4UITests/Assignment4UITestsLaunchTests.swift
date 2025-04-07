//
//  Assignment4UITestsLaunchTests.swift
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
final class Assignment4UITestsLaunchTests: XCTestCase {
=======
class Assignment4UITestsLaunchTests: XCTestCase {
>>>>>>> 480ace2773d13c5070af29e2ef21cae5f60418fc

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
