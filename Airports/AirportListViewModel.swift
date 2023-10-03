import Foundation

class AirportListViewModel: ObservableObject {
  @Published var airports: [Airport] = []

  init() {
    loadAirports()
  }

  private func loadAirports() {
    guard let url = Bundle.main.url(forResource: "airports", withExtension: "json") else {
      print("Invalid filename/path.")
      return
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      self.airports = try decoder.decode([Airport].self, from: data)
    } catch {
      print("Error decoding the airport list: \(error)")
    }
  }
}
