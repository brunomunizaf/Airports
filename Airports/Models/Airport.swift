struct Airport: Codable, Identifiable, Equatable {
  let id: String
  let lon: Float
  let isOpen: Bool
  let name: String
  let continent: String
  let type: String
  let lat: Float
  let country: Country

  enum CodingKeys: String, CodingKey {
    case id = "iata"
    case lon, country, isOpen, name, continent, type, lat
  }
}
