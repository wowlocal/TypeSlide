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

	var codeView: some View {
		CodeText(code)
			.codeTextColors(.theme(theme))
			.codeTextMode(.language(.swift))
			.fontStyle(.code)
			//.blendMode(debug ? BlendMode.color : BlendMode.normal)
			.blendMode(selectedBlendMode)
			.padding(50)
			.background(
				RoundedRectangle(cornerRadius: 20.00, style: .continuous)
					.fill(.ultraThinMaterial)
					.offset(y: 10)
					.zIndex(0)
			)
			.padding(.trailing, 120)
	}

	var body: some View {
		VStack {
			Picker(selection: $selectedBlendMode, label: Text("")) {
				ForEach(blendModes, id: \.self) {
					Text("\($0)")
				}
			}.frame(width: 100, height: 200).scaleEffect(2)
			Picker(selection: $theme, label: Text("")) {
				ForEach(HighlightTheme.allCases, id: \.self) {
					Text("\($0)")
				}
			}.frame(width: 100, height: 200).scaleEffect(2)
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
