//
//  StretchTextView.swift
//  TypeSlide
//
//  Created by Misha Nya on 06.04.2024.
//

import SwiftUI
import HighlightSwift

struct SwiftCodeHighlightView: View {
	@State var code: String

	init(code: String) {
		self.code = code
	}

	@Environment(\.debug) var debug

	@State private var selectedBlendMode = BlendMode.normal
	let blendModes: [BlendMode] = [.normal, .screen, .colorDodge, .plusLighter, .luminosity]

	@State private var theme: HighlightTheme = .a11y

	// .screen, .colorDodge, .plusLighter неплохо работает
	// .luminosity прикольно с светлыми темами

	// .screen или .plusLighter

	// .screen збс, а .plusLighter делает ярче там где не надо

	// тема: .xcode или .gradient или .solarized, .paraiso
	// low contrast: .horizon, .edge
	// контрастная комплиментарная: .gradient

	var codeView: some View {
		CodeText(code)
			.codeTextColors(.theme(.gradient))
			.codeTextMode(.language(.swift))
			.fontStyle(.code)
			//.blendMode(debug ? BlendMode.color : BlendMode.normal)
			.blendMode(.screen)
			.padding(50)
			.background(
				RoundedRectangle(cornerRadius: 30, style: .continuous)
//				UnevenRoundedRectangle(topLeadingRadius: 16,
//									   bottomLeadingRadius: 30,
//									   bottomTrailingRadius: 160,
//									   topTrailingRadius: 30,
//									   style: .continuous)
//				UnevenRoundedRectangle(topLeadingRadius: 60,
//									   bottomLeadingRadius: 10,
//									   bottomTrailingRadius: 150,
//									   topTrailingRadius: 10,
//									   style: .continuous)
//				RotatedShape(shape: RoundedRectangle(cornerRadius: 30),
//										  angle: Angle(degrees: 2),
//										  anchor: .topLeading)
					.fill(.ultraThinMaterial)
					.offset(y: 0)
					.zIndex(0)
			)
			.padding(.trailing, 120)
			.padding(.leading, -86)
	}

	var body: some View {
		VStack {
//			Picker(selection: $selectedBlendMode, label: Text("")) {
//				ForEach(blendModes, id: \.self) {
//					Text("\($0)")
//				}
//			}.frame(width: 100, height: 200).scaleEffect(2)
//			Picker(selection: $theme, label: Text("")) {
//				ForEach(HighlightTheme.allCases, id: \.self) {
//					Text("\($0)")
//				}
//			}.frame(width: 100, height: 200).scaleEffect(2)
			codeView
		}
	}
}

#Preview {
	SwiftCodeHighlightView(code: """
		import SwiftUI

		struct ContentView: View {
			var body: some View {
				Text("Hello, World!")
					.padding()
			}
		}

		struct ContentView_Previews: PreviewProvider {
			static var previews: some View {
				ContentView()
			}
		}
		""")
		.padding()

}
