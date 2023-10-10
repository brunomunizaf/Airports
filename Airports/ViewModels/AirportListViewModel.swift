import Foundation

struct SectionItem: Identifiable {
  var id: String { continent.rawValue }
  var continent: Continent
  var subsections: [SubsectionItem]
}

struct SubsectionItem: Identifiable {
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

      let allAirports = try decoder.decode([Airport].self, from: data)

      // Group airports by their continent.
      let groupedByContinent = Dictionary(grouping: allAirports, by: \.continent)

      // For each group of airports (grouped by continent), further group them by their country.
      let sectionItems = groupedByContinent.map { (continent, airports) -> SectionItem in
        let groupedByCountry = Dictionary(grouping: airports, by: \.country)
          .sorted(by: { $0.key.name < $1.key.name })
          .map { (countries, itsAirports) in
            SubsectionItem(country: countries, airports: itsAirports.sorted { $0.name < $1.name })
          }

        return SectionItem(continent: continent, subsections: groupedByCountry)
      }

      self.items = sectionItems.sorted(by: { $0.continent.name < $1.continent.name })
    } catch {
      print("Error decoding the airport list: \(error)")
    }
  }
}
