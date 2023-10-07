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
              AirportInfoView(airport: airport)
            } label: {
              Text(airport.name)
            }
          }
        }
      }
      .navigationTitle("Airports")
    }
    .onAppear(perform: loadData)
    .searchable(text: $searchText) {
      ForEach(searchResults) { result in
        Section(header: Text(result.country.name)) {
          ForEach(result.airports) { airport in
            HStack {
              Text(airport.name)
              Spacer()
              Text(airport.id)
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

  func loadData() {
    do {
      let data = try viewModel.getDataFromJSON()
      viewModel.loadAirports(from: data)
    } catch {
      print("Error loading data: \(error)")
    }
  }
}

struct AirportListView_Previews: PreviewProvider {
  static var previews: some View {
    AirportListView()
  }
}
