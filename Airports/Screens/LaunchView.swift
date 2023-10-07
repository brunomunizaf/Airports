import Lottie
import SwiftUI

struct LaunchView: View {
  @State private var navigateToNextScreen = false

  var body: some View {
    NavigationStack {
      ZStack {
        LottieView(animation: .named("launch_animation"))
          .playing()
          .animationDidFinish { completed in
            if completed {
              navigateToNextScreen = true
            }
          }
        Text("Terminal 1")
          .font(.headline)
          .padding(.bottom, 70)
        NavigationLink(
          destination: AirportListView().navigationBarBackButtonHidden(true),
          isActive: $navigateToNextScreen
        ) { EmptyView() }
      }
    }
  }
}
