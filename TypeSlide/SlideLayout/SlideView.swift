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

struct DebugEnvironmentKey: EnvironmentKey {
	static let defaultValue: Bool = false // Default value for the debug variable
}

extension EnvironmentValues {
	var debug: Bool {
		get { self[DebugEnvironmentKey.self] }
		set { self[DebugEnvironmentKey.self] = newValue }
	}
}

struct BGColor: PreferenceKey {
	static var defaultValue: Color = .white // Default color

	static func reduce(value: inout Color, nextValue: () -> Color) {
		value = nextValue()
	}
}

struct SlideView<Content: View>: View {
	let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

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

	@State var debug: Bool = false

	@ViewBuilder
	var debugButton: some View {
		Button(action: {
			debug.toggle()
		}) {
			Text("Toggle Button")
		}
		.frame(width: 0, height: 0)
		.opacity(0)
		.keyboardShortcut(KeyEquivalent("d"), modifiers: [.command])
	}

	@State var backgroundColor: Color = .white

	var body: some View {
		GeometryReader { geometry in
			let farmeSize: (width: CGFloat, height: CGFloat) = slideFrame(geometry.size)
			ZStack {
				debugButton
				backgroundColor //debug ? Color.gray : Color.white // Slide background color
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
			.onPreferenceChange(BGColor.self) {
				backgroundColor = $0
			}
		}
		.shadow(radius: 0.01)
	}
}
