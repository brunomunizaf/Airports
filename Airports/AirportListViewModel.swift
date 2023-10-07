import Foundation

struct SectionItem: Identifiable {
  var id: String { country.iso }
  var country: Country
  var airports: [Airport]
}

enum AirportListViewModelError: Error {
  case fileNotFound
}

final class AirportListViewModel: ObservableObject {
  @Published var items: [SectionItem] = []

  public func getDataFromJSON(bundle: Bundle = .main) throws -> Data {
    guard let airportsURL = bundle.url(forResource: "airports", withExtension: "json") else {
      throw AirportListViewModelError.fileNotFound
    }
    return try Data(contentsOf: airportsURL)
  }

  public func loadAirports(from data: Data) {
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase

      let airports = try decoder.decode([Airport].self, from: data)
      let groupedByCountry = Dictionary(grouping: airports, by: \.country)
        .sorted(by: { $0.key.name < $1.key.name })

      items = groupedByCountry.map { key, value in
        SectionItem(country: key, airports: value.sorted(by: { $0.name < $1.name }))
      }
    } catch {
      print("Error decoding the airport list: \(error)")
    }
  }
}
