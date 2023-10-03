import XCTest
@testable import Airports

final class AirportsTests: XCTestCase {
  func testDecoding() {
    let mockAirport = Airport(
      id: "CTF",
      lon: "-91.916664",
      iso: "PE",
      status: 1,
      name: "Contamana Airport",
      continent: "SA",
      type: "airport",
      lat: "14.766667",
      size: "small"
    )

    let decoder = JSONDecoder()
    let bundle = Bundle(for: AirportsTests.self)
    guard let url = bundle.url(forResource: "mock_airports", withExtension: "json") else {
      return XCTFail("Can't find mock airports list")
    }
    do {
      let data = try Data(contentsOf: url)
      let airport = try decoder.decode([Airport].self, from: data).first!
      XCTAssertEqual(airport, mockAirport)
    } catch {
      XCTFail("Decoding failed: \(error)")
    }
  }
}
