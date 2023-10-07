import MapKit
import SwiftUI

struct AirportInfoView: View {
  let airport: Airport

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: 10) {
          HStack {
            Text("Name:")
              .font(.headline)
            Text(airport.name)
          }
          HStack {
            HStack {
              Text("Identifier:")
                .font(.headline)
              Text(airport.id)
            }
            HStack {
              Text("Continent:")
                .font(.headline)
              Text(airport.continent)
            }
          }
          HStack {
            Text("Coordinates:")
              .font(.headline)
            Text("Lat: \(airport.lat)")
            Text("Lon: \(airport.lon)")
          }
        }.padding()

        Map(position: .constant(.region(MKCoordinateRegion(
          center: CLLocationCoordinate2D(
            latitude: Double(airport.lat),
            longitude: Double(airport.lon)
          ),
          span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
          ))
        ))) {
          Marker(airport.id, coordinate: .init(
            latitude: Double(airport.lat),
            longitude: Double(airport.lon)
          ))
        }
        .mapStyle(.hybrid)
      }
    }.navigationTitle(airport.name)
  }
}

struct AirportInfoView_Previews: PreviewProvider {
  static var previews: some View {
    AirportInfoView(airport: .mock)
  }
}

private extension Airport {
  static let mock = Airport(
    id: "CTF",
    lon: -91.916664,
    isOpen: true,
    name: "Coatepeque Airport",
    continent: "NA",
    type: "airport",
    lat: 14.766667,
    country: .init(
      iso: "GT",
      name: "Guatemala"
    )
  )
}
