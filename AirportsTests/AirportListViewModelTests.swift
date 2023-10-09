import XCTest
@testable import Airports

final class AirportListViewModelTests: XCTestCase {
  var sut: AirportListViewModel!

  override func tearDown() {
    sut = nil
  }

  override func setUpWithError() throws {
    sut = AirportListViewModel()
  }

  func testLoadAirportsWithData() {
    sut.loadAirports(from: Airport.mockJSON.data(using: .utf8)!)
    XCTAssertEqual(sut.items.count, 1)

    let sectionItem = sut.items[0]
    XCTAssertEqual(sectionItem.airports.count, 1)

    let airport = sectionItem.airports[0]
    XCTAssertEqual(airport.id, "CTF")
    XCTAssertEqual(airport.isOpen, true)
    XCTAssertEqual(airport.lat, 14.766667)
    XCTAssertEqual(airport.continent, "NA")
    XCTAssertEqual(airport.lon, -91.916664)
    XCTAssertEqual(airport.type, "airport")
    XCTAssertEqual(airport.name, "Coatepeque Airport")
    XCTAssertEqual(airport.country, Country(iso: "GT", name: "Guatemala"))
  }

  func testLoadAirportsWithEmptyData() {
    let emptyData = "[]".data(using: .utf8)!
    sut.loadAirports(from: emptyData)

    XCTAssertEqual(sut.items.count, 0)
  }

  func testGetDataFromJSON() {
    let data = try? sut.getDataFromJSON(bundle: MockBundle(
      mockFileName: "mock_airports"
    ))
    XCTAssertNotNil(data)
  }

  func testGetDataFromJSONFileNotFound() {
    let bundle = MockBundle(mockFileName: "anything_else")

    XCTAssertThrowsError(try sut.getDataFromJSON(bundle: bundle)) { error in
      XCTAssertEqual(error as? AirportListViewModelError, .fileNotFound)
    }
  }
}

private class MockBundle: Bundle {
  let mockFileName: String

  init(mockFileName: String) {
    self.mockFileName = mockFileName
    super.init()
  }

  override func url(forResource name: String?, withExtension ext: String?) -> URL? {
    Bundle(for: AirportListViewModelTests.self).url(
      forResource: mockFileName,
      withExtension: "json"
    )
  }
}

private extension Airport {
  static let mockJSON = "[{\"iata\": \"CTF\", \"lon\": -91.916664, \"is_open\": true, \"name\": \"Coatepeque Airport\", \"continent\": \"NA\", \"type\": \"airport\", \"lat\": 14.766667, \"country\": {\"iso\": \"GT\", \"name\": \"Guatemala\"}}]"
}
