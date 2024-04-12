//
//  SectionStart.swift
//  TypeSlide
//
//  Created by Misha Nya on 12.04.2024.
//

import SwiftUI

typealias TitleSlide = SectionStart

struct SectionStart: View {
	var title: String // будет анимироваться между инстансами TitleSubtitleModern т.к. общая structural identity
	var subtitle: String

	// @EnvironmentObject var debug: DebugState
	@Environment(\.debug) var debug

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(title)
				.foregroundColor(.white)
				.fontStyle(.ultraTitle)
				//.id("1") // если id идентичный то анимация будет даже с разным текстом
			Text(subtitle)
				.foregroundColor(.white)
				.fontStyle(.modernSubtitle)
				.offset(x: 5)
				.zIndex(1)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
		.padding(30)
		.preference(key: BGColor.self, value: C.deepPurple)
	}
}
