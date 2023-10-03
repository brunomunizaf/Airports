import SwiftUI

struct AirportListView: View {
  @StateObject var viewModel = AirportListViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.airports) { airport in
        NavigationLink {
          Text(airport.id)
          Text(airport.name)
          Text(airport.continent)
          if let lat = airport.lat {
            Text(lat)
          }
          if let lon = airport.lon {
            Text(lon)
          }
        } label: {
          Text(airport.name)
        }
      }
      .navigationTitle("Airports")
    }
  }
}

struct AirportListView_Previews: PreviewProvider {
  static var previews: some View {
    AirportListView()
  }
}
