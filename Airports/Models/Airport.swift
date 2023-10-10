struct Airport: Codable, Identifiable, Equatable {
  let id: String
  let lon: Float
  let isOpen: Bool
  let name: String
  let continent: Continent
  let type: String
  let lat: Float
  let country: Country
  let website: String?

  enum CodingKeys: String, CodingKey {
    case id = "iata"
    case lon, country, isOpen, name, continent, type, lat, website
  }
}

enum Continent: String, Codable, Equatable, CaseIterable {
  case asia = "AS"
  case africa = "AF"
  case europe = "EU"
  case oceania = "OC"
  case southAmerica = "SA"
  case northAmerica = "NA"

  var name: String {
    switch self {
    case .asia:
      return "Asia"
    case .africa:
      return "Africa"
    case .europe:
      return "Europe"
    case .oceania:
      return "Oceania"
    case .southAmerica:
      return "South America"
    case .northAmerica:
      return "North America"
    }
  }
}
