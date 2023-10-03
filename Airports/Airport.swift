struct Airport: Codable, Identifiable, Equatable {
  let id: String
  let lon: Float
  let iso: String
  let isOpen: Bool
  let name: String
  let continent: String
  let type: String
  let lat: Float

  enum CodingKeys: String, CodingKey {
    case id = "iata"
    case lon, iso, isOpen, name, continent, type, lat
  }
}
