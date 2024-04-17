//
//  SlideView.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

class DebugState: ObservableObject {
    @Published var isEnabled: Bool = false
}

struct BGColor: PreferenceKey {
	static var defaultValue: Color = .white // Default color

	static func reduce(value: inout Color, nextValue: () -> Color) {
		value = nextValue()
	}
}

struct SlideView<Content: View>: View {
	@ViewBuilder var content: Content

	private let aspectRatio: CGFloat = 16 / 9 // 4 / 3

	// @StateObject var debugState = DebugState()

	private let minWidth: CGFloat = 500
	private var minHeight: CGFloat {
		minWidth / aspectRatio
	}

	func slideFrame(_ size: CGSize) -> (width: CGFloat, height: CGFloat) {
		let frameWidth: CGFloat
		let frameHeight: CGFloat
		let parentAspectRatio = size.width / size.height

		if aspectRatio > parentAspectRatio {
			// Parent is taller than our desired aspect ratio, so we base our size on the parent's width
			frameWidth = max(size.width, minWidth)
			frameHeight = frameWidth / aspectRatio
		} else {
			// Parent is wider than our desired aspect ratio, so we base our size on the parent's height
			frameHeight = max(size.height, minHeight)
			frameWidth = frameHeight * aspectRatio
		}

		return (frameWidth, frameHeight)
	}

	@Environment(\.debug) var debug

	// @State // should not be state if manipulated outside of the view
	var backgroundColor: Color = .white
	var theEnd: Bool = false

	let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
	@State private var colorIndex = 0
	let colors: [Color] =
	//generateRgbColorsFunkyOrangePink(n: 255)
	createColorGradient(sampleSize: 255).map { ($0[0], $0[1], $0[2]) }
		.map { rgb in
			Color(.displayP3, red: Double(rgb.0) / 255, green: Double(rgb.1) / 255, blue: Double(rgb.2) / 255)
		}

	var body: some View {
		GeometryReader { geometry in
			let farmeSize: (width: CGFloat, height: CGFloat) = slideFrame(geometry.size)
			ZStack {
				backgroundColor //debug ? Color.gray : Color.white // Slide background color
					.mask(
						Circle().scale(theEnd ? 0.2 : 2)
					)
				RadialGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.75)]), center: .center, startRadius: 140, endRadius: geometry.size.width / 2)
					.opacity(theEnd ? 0.8 : 0) // Adjust opacity to control the darkness of the corners
				// Color.clear
				// colors[colorIndex]
				content
					.padding(80)
					.frame(width: 1920, height: 1080)
					//.background(backgroundColor)
					.scaleEffect(farmeSize.width / 1920)
					.environment(\.debug, debug)
					//.environmentObject(debugState)
			}
			.frame(width: farmeSize.width, height: farmeSize.height)
			.cornerRadius(AppSizes.cornerRadius)
			.shadow(radius: 5)
			// Ensures the slide maintains its aspect ratio and is centered
			.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
//			.onPreferenceChange(BGColor.self) {
//				backgroundColor = $0
//			}
//			.onReceive(timer) { _ in
//				self.colorIndex = (self.colorIndex + 1) % self.colors.count
//			}
		}
		.shadow(radius: 0.01)
	}

	func bg(color: Color) -> Self {
		var copy = self
		copy.backgroundColor = color
		return copy
	}

	func theEnd(_ end: Bool) -> Self {
		var copy = self
		copy.theEnd = end
		return copy
	}
}

