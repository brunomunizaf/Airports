import SwiftUI

struct AirportListView: View {
  @State private var searchText = ""
  @StateObject var viewModel = AirportListViewModel()

  var body: some View {
    NavigationView {
      List(viewModel.items) { sectionItem in
        Section(header: Text(sectionItem.continent.name)) {
          ForEach(sectionItem.subsections) { subsection in
            DisclosureGroup(subsection.country.name) {
              ForEach(subsection.airports) { airport in
                NavigationLink {
                  AirportInfoView(airport: airport)
                } label: {
                  Text(airport.name)
                }
              }
            }
          }
        }
      }
      .navigationTitle("Airports")
    }
    .onAppear(perform: loadData)
    .searchable(text: $searchText) {
      ForEach(searchResults) { sectionItem in
        Section(header: Text(sectionItem.continent.name)) {
          ForEach(sectionItem.subsections) { subsection in
            HStack {
              Text(subsection.country.name)
              Spacer()
              Text(subsection.country.iso)
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
        for section in viewModel.items {
          var filteredSubsections: [SubsectionItem] = []

          for subsection in section.subsections {
            if subsection.country.name.contains(searchText) {
              filteredSubsections.append(subsection)
            } else {
              let matchingAirports = subsection.airports.filter { $0.name.contains(searchText) }
              if !matchingAirports.isEmpty {
                var newSubsection = subsection
                newSubsection.airports = matchingAirports
                filteredSubsections.append(newSubsection)
              }
            }
          }

          if !filteredSubsections.isEmpty {
            var newSection = section
            newSection.subsections = filteredSubsections
            filteredItems.append(newSection)
          }
        }
        return filteredItems
      }
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
