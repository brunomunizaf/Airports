import SwiftUI

struct AirportListView: View {
  @State private var searchText = ""
  @StateObject var viewModel = AirportListViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.items) { item in
        Section(header: Text(item.country.name)) {
          ForEach(item.airports) { airport in
            NavigationLink {
              Text(airport.id)
              Text(airport.name)
              Text(airport.continent)
              Text("\(airport.lat)")
              Text("\(airport.lon)")
            } label: {
              Text(airport.name)
            }
          }
        }
      }
      .navigationTitle("Airports")
    }
    .searchable(text: $searchText) {
      ForEach(searchResults) { result in
        Section(header: Text(result.country.name)) {
          ForEach(result.airports) { airport in
            HStack {
              Text(airport.id)
              Text(airport.name)
            }
          }
        }
      }
    }
  }

  var searchResults: [SectionItem] {
    if searchText.isEmpty {
      return viewModel.items
    } else {
      var filteredItems: [SectionItem] = []
      for item in viewModel.items {
        if item.country.name.contains(searchText) {
          filteredItems.append(item)
        } else {
          let matchingAirports = item.airports.filter { $0.name.contains(searchText) }
          if !matchingAirports.isEmpty {
            var newItem = item
            newItem.airports = matchingAirports
            filteredItems.append(newItem)
          }
        }
      }
      return filteredItems
    }
  }
}

struct AirportListView_Previews: PreviewProvider {
  static var previews: some View {
    AirportListView()
  }
}
