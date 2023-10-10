import MapKit
import SwiftUI

struct AirportInfoView: View {
  let airport: Airport
  @State private var isSheetPresented = false

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: 10) {
          DetailRow(
            label: "Name",
            value: airport.name,
            icon: Image(systemName: "airplane")
          )
          DetailRow(
            label: "Identifier",
            value: airport.id,
            icon: Image(systemName: "barcode.viewfinder")
          )
          DetailRow(
            label: "Continent",
            value: airport.continent.name,
            icon: Image(systemName: "map")
          )
          DetailRow(
            label: "Coordinates",
            value: "Lat: \(airport.lat) Lon: \(airport.lon)",
            icon: Image(systemName: "mappin.and.ellipse")
          )
        }
        .padding()
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
    }
    .navigationTitle(airport.name)
    .toolbar {
      if let _ = airport.website {
        Button(action: {
          isSheetPresented.toggle()
        }) {
          Image(systemName: "plus")
            .foregroundColor(.primary)
        }
      }
    }
    .sheet(isPresented: $isSheetPresented) {
      if let website = airport.website {
        WebView(urlString: website)
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity
        )
      }
    }
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
    continent: .europe,
    type: "airport",
    lat: 14.766667,
    country: .init(
      iso: "GT",
      name: "Guatemala"
    ),
    website: nil
  )
}
