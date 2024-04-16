//
//  StretchTextView.swift
//  TypeSlide
//
//  Created by Misha Nya on 06.04.2024.
//

import SwiftUI
import HighlightSwift

struct MetalCodeShowcase: View {
	let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
	@State private var timerRunning = false
	@State private var direction: ProgressDirection = .forward
	enum ProgressDirection {
		case forward, backward, stopped
	}
	@State var progress: Double = 0

	var sample: KeyPath<Samples, String>
	@Environment(\.codeSamples) var codeSamples

	@State var pixelated = false

	var body: some View {
		Text(
			pixelated ? "Про Metal были сессии ранее" : codeSamples.colored[sample] ?? ""
		)
		.fontStyle(
			AppFont(size: pixelated ? 100 : 40,
					weight: pixelated ? .heavy : .bold,
					design: pixelated ? .default : .monospaced)
		)
		.shadow(color: pixelated ? Color.clear : Color(red: 0.50, green: 0.13, blue: 1.00),
				radius: pixelated ? 0 : 25
		)
		.frame(minWidth: 800)
		.layerEffect(
			ShaderLibrary.pixelate(.float(progress)),
				maxSampleOffset: CGSize(width: progress, height: progress)
		)
		.onReceive(timer) { _ in
			guard timerRunning else { return }
			switch direction {
			case .forward:
				progress += 0.8
				if progress >= 30 { // Assuming 100 is the max progress
					direction = .backward
					withAnimation {
						pixelated = true
					}
				}
			case .backward:
				progress -= 1
				if progress <= 0 {
					direction = .stopped
				}
			case .stopped:
				break
			}
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				timerRunning = true
			}
		}
	}
}

struct SwiftCodeHighlightView: View {
	let code: AttributedString

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
		Text(code)
//			.codeTextColors(.theme(.gradient))
//			.codeTextMode(.language(.swift))
			.fontStyle(.code)
			.frame(minWidth: 800)
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
			//.padding(.trailing, 120)
			//.padding(.leading, -86)
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
