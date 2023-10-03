import Foundation

struct SectionItem: Identifiable {
  var id: String { country.iso }
  var country: Country
  var airports: [Airport]
}

final class AirportListViewModel: ObservableObject {
  @Published var items: [SectionItem] = []

  init() {
    loadAirports()
  }

  private func loadAirports() {
    guard let airportsURL = Bundle.main.url(forResource: "airports", withExtension: "json") else {
      print("Invalid filename/path.")
      return
    }
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let airportsData = try Data(contentsOf: airportsURL)
      let airports = try decoder.decode([Airport].self, from: airportsData)
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
