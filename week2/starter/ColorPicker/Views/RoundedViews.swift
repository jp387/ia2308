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

struct RoundedRectView: View {
  @Binding var foregroundColor: Color
  
  var body: some View {
    VStack {
      RoundedRectangle(cornerRadius: 0)
        .foregroundColor(foregroundColor)
        .border(.brown.opacity(Constants.Color.roundedRectBorderOpacity), width: Constants.General.roundedRectBorderWidth)
    }
  }
}

struct ButtonView: View {
  @Binding var foregroundColor: Color
  @Binding var redColor: Double
  @Binding var greenColor: Double
  @Binding var blueColor: Double
  var text: String
  
  var body: some View {
    Button(text) {
      foregroundColor = Color(red: redColor / Constants.Color.maxRGBIntensity, green: greenColor / Constants.Color.maxRGBIntensity, blue: blueColor / Constants.Color.maxRGBIntensity)
    }
    .bold()
    .padding()
    .foregroundColor(Color("ButtonTextColor"))
    .background(
      RoundedRectangle(cornerRadius: Constants.General.roundedRectCornerRadius)
        .fill(Color("ButtonColor"))
        .overlay(
          RoundedRectangle(cornerRadius: Constants.General.roundedRectCornerRadius)
            .strokeBorder(lineWidth: Constants.General.strokeBorderWidth)
            .foregroundColor(.white)
        )
    )
  }
}

struct RoundedViews_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      RoundedRectView(foregroundColor: .constant(Color.orange))
        .frame(width: 300, height: 300)
      ButtonView(foregroundColor: .constant(Color.red), redColor: .constant(0.0), greenColor: .constant(0.0), blueColor: .constant(0.0), text: "Set Color")
    }
    VStack {
      RoundedRectView(foregroundColor: .constant(Color.orange))
        .frame(width: 300, height: 300)
      ButtonView(foregroundColor: .constant(Color.red), redColor: .constant(0.0), greenColor: .constant(0.0), blueColor: .constant(0.0), text: "Set Color")
    }
    .preferredColorScheme(.dark)
  }
}
