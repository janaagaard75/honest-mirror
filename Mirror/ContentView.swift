import SwiftUI
import UIKit

struct ContentView: View {
    @State private var e = false
    @State private var brightnessBeforeFlashlight: CGFloat = UIScreen.main.brightness

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CameraPreview()
                    .allowsHitTesting(false)
                VStack(spacing: 0) {
                    Color.white
                        .frame(height: geometry.size.height / 6)
                        .opacity(e ? 1 : 0)
                    Spacer(minLength: 0)
                    Color.white
                        .frame(height: geometry.size.height / 6)
                        .opacity(e ? 1 : 0)
                }
            }
        }
        .ignoresSafeArea()
        .background(Color.black)
        .statusBarHidden()
        .persistentSystemOverlays(.hidden)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                e.toggle()
            }
        }
        .onChange(of: e) { _, turnedOn in
            if turnedOn {
                brightnessBeforeFlashlight = UIScreen.main.brightness
                UIScreen.main.brightness = 1.0
            } else {
                UIScreen.main.brightness = brightnessBeforeFlashlight
            }
        }
    }
}
