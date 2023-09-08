/// Copyright (c) 2023 Kodeco Inc.
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ColorPickerView: View {
  @Binding var redColor: Double
  @Binding var greenColor: Double
  @Binding var blueColor: Double
  @Binding var foregroundColor: Color
  @Binding var orientation: UIDeviceOrientation
  
  var body: some View {
    Group {
      if orientation.isLandscape {
        LandscapeView(redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, foregroundColor: $foregroundColor)
      } else {
        PortraitView(redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, foregroundColor: $foregroundColor)
      }
    }
    .onRotate { newOrientation in
      orientation = newOrientation
    }
  }
}

struct LandscapeView: View {
  @Binding var redColor: Double
  @Binding var greenColor: Double
  @Binding var blueColor: Double
  @Binding var foregroundColor: Color
  
  var body: some View {
    HStack {
      VStack {
        TitleTextViews(text: "Color Picker")
        RoundedRectView(foregroundColor: $foregroundColor)
      }
      VStack {
        SliderView(color: $redColor, text: "Red")
          .tint(.red)
        SliderView(color: $greenColor, text: "Green")
          .tint(.green)
        SliderView(color: $blueColor, text: "Blue")
        ButtonView(foregroundColor: $foregroundColor, redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, text: "Set Color")
      }
      .padding(.horizontal)
    }
    .background(Color("BackgroundColor"))
    .padding()
  }
}

struct PortraitView: View {
  @Binding var redColor: Double
  @Binding var greenColor: Double
  @Binding var blueColor: Double
  @Binding var foregroundColor: Color
  
  var body: some View {
    VStack {
      TitleTextViews(text: "Color Picker")
      RoundedRectView(foregroundColor: $foregroundColor)
      VStack {
        SliderView(color: $redColor, text: "Red")
          .tint(.red)
        SliderView(color: $greenColor, text: "Green")
          .tint(.green)
        SliderView(color: $blueColor, text: "Blue")
        ButtonView(foregroundColor: $foregroundColor, redColor: $redColor, greenColor: $greenColor, blueColor: $blueColor, text: "Set Color")
      }
      .padding()
    }
    .background(Color("BackgroundColor"))
    .padding(20)
  }
}

// Device Rotation Source Code - https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
struct DeviceRotationViewModifier: ViewModifier {
  let action: (UIDeviceOrientation) -> Void
  
  func body(content: Content) -> some View {
    content
      .onAppear()
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        action(UIDevice.current.orientation)
      }
  }
}

extension View {
  func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
    self.modifier(DeviceRotationViewModifier(action: action))
  }
}

struct ColorPickerView_Previews: PreviewProvider {
  static var previews: some View {
    ColorPickerView(redColor: .constant(250), greenColor: .constant(100), blueColor: .constant(50), foregroundColor: .constant(Color.yellow), orientation: .constant(UIDeviceOrientation.portrait))
    ColorPickerView(redColor: .constant(250), greenColor: .constant(100), blueColor: .constant(50), foregroundColor: .constant(Color.yellow), orientation: .constant(UIDeviceOrientation.landscapeRight)).previewInterfaceOrientation(.landscapeRight)
  }
}
