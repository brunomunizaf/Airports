import SwiftUI

struct DetailRow: View {
  var label: String
  var value: String
  var icon: Image

  var body: some View {
    HStack(spacing: 20) {
      icon
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundColor(.primary)
      VStack(alignment: .leading) {
        Text(label)
          .font(.subheadline)
          .foregroundColor(.gray)
        Text(value)
          .font(.headline)
      }
      Spacer()
    }
  }
}
