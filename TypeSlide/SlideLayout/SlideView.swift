//
//  SlideView.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

struct SlideView<Content: View>: View {
	let content: Content

	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}

	private let aspectRatio: CGFloat = 16 / 9 // 4 / 3

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

	@State var scaleFactor: CGFloat = 1.0
	var padding: CGFloat {
		50 * scaleFactor
	}

	var body: some View {
		GeometryReader { geometry in
			let farmeSize: (width: CGFloat, height: CGFloat) = slideFrame(geometry.size)
			ZStack {
				Color.white // Slide background color
				content
					.background(Color.clear)
					.padding(padding)
			}
			.onAppear {
				scaleFactor = farmeSize.width / 2000
			}
			.onChange(of: geometry.size) {
				scaleFactor = farmeSize.width / 2000
			}
			.frame(width: farmeSize.width, height: farmeSize.height)
			.cornerRadius(AppSizes.cornerRadius)
			.shadow(radius: 5)
			// Ensures the slide maintains its aspect ratio and is centered
			.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
			.environment(\.scaleFactor, farmeSize.width / 2000)
		}.shadow(radius: 0.01)
	}
}
