//
//  TitleSubtitle.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

struct SlideViewExample: View {
	var title: String = ""
	var content: String = ""

	@Environment(\.scaleFactor) var scaleFactor: CGFloat
	var spacing: CGFloat {
		30 * scaleFactor
	}

	var body: some View {
		VStack(alignment: .leading, spacing: spacing) {
			Text(title)
				.colorInvert()
				.scalableFont(.title) // Dynamic font size with a minimum value
				.fontWeight(.bold)

			Text(content)
				.colorInvert()
				.scalableFont(.subtitle) // Slightly smaller dynamic font size with a minimum value
				.opacity(0.7)
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
