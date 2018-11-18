import XCTest
import SwiftCron

class TimeZoneTests: XCTestCase {

    func testTimeZoneDifferencesResultInVariationOfNextRunDate() {
        let newYorkTZ = TimeZone(identifier: "America/New_York")!
        let losAngelesTZ = TimeZone(identifier: "America/Los_Angeles")!

        let cronExpression = CronExpression(cronString: "0 10 12 9 * *")!

        let nextRunNewYorkTZ = cronExpression.getNextRunDateFromNow(adjustingForTimeZone: newYorkTZ)!
        let nextRunLosAngelesTZ = cronExpression.getNextRunDateFromNow(adjustingForTimeZone: losAngelesTZ)!

        let milliDiff = nextRunLosAngelesTZ.timeIntervalSince1970 - nextRunNewYorkTZ.timeIntervalSince1970
        let hourDiff = milliDiff / (60*60)

        let expectedTimezoneOffset: Double = 3
        XCTAssertEqual(expectedTimezoneOffset, hourDiff)
    }
}
