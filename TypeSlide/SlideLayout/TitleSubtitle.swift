//
//  TitleSubtitle.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

struct TitleSubtitleClassic: View {
	var title: String
	var subtitle: String

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(title)
				.colorInvert()
				.fontStyle(.title) // Dynamic font size with a minimum value
				.fontWeight(.bold)

			Text(subtitle)
				.colorInvert()
				.fontStyle(.subtitle) // Slightly smaller dynamic font size with a minimum value
				.opacity(0.7)
				.offset(x: 5)
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}

struct TitleSubtitleModern: View {
	var title: String
	var subtitle: String

	// @EnvironmentObject var debug: DebugState
	@Environment(\.debug) var debug

	var body: some View {
		// Bold title at the center and subtitle above it
		VStack(alignment: .center, spacing: 0) {
			Text(subtitle)
				.foregroundColor(.white)
				.fontStyle(.superSubtitle)
				.zIndex(1)

			Text(title)
				.foregroundColor(.white)
				.fontStyle(.superTitle)
		}
		.background(
			Group {
				if debug {
					GeometryReader { geometry in
						Capsule(style: .continuous)
							.fill(.ultraThinMaterial)
							.scaleEffect(1.4)
							.offset(y: 10)
							.zIndex(0)
					}
				}
			}
		)
		.preference(key: BGColor.self, value: C.deepPurple)
	}
}
