import XCTest
@testable import Airports

final class AirportsTests: XCTestCase {
  let json = """
    {
      "iata": "CTF",
      "lon": "-91.916664",
      "iso": "PE",
      "status": 1,
      "name": "Contamana Airport",
      "continent": "SA",
      "type": "airport",
      "lat": "14.766667",
      "size": "small"
    }
    """

  func testDecoding() {
    let decoder = JSONDecoder()

    do {
      let airport = try decoder.decode(Airport.self, from: json.data(using: .utf8)!)
      XCTAssertEqual(airport.id, "CTF")
      XCTAssertEqual(airport.lon, "-91.916664")
      XCTAssertEqual(airport.iso, "PE")
      XCTAssertEqual(airport.status, 1)
      XCTAssertEqual(airport.name, "Contamana Airport")
      XCTAssertEqual(airport.continent, "SA")
      XCTAssertEqual(airport.type, "airport")
      XCTAssertEqual(airport.lat, "14.766667")
      XCTAssertEqual(airport.size, "small")
    } catch {
      XCTFail("Decoding failed: \(error)")
    }
  }
}
