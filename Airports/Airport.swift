struct Airport: Codable, Identifiable {
  let id: String
  let lon: String?
  let iso: String
  let status: Int
  let name: String
  let continent: String
  let type: String
  let lat: String?
  let size: String?

  enum CodingKeys: String, CodingKey {
    case id = "iata"
    case lon, iso, status, name, continent, type, lat, size
  }
}
