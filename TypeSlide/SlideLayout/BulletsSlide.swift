//
//  BulletsSlide.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI


struct TitleAndBulletsSlide: View {
	var title: String
	var bullets: [String]

	@Environment(\.scaleFactor) var scaleFactor: CGFloat
	var spacing: CGFloat {
		30 * scaleFactor
	}
	var padding: CGFloat {
		50 * scaleFactor
	}

	var body: some View {
		VStack(alignment: .leading, spacing: spacing) {
			Text(title)
				.scalableFont(.title)
				.colorInvert()
				.fontWeight(.bold)

			ForEach(bullets, id: \.self) { bullet in
				HStack(alignment: .top) {
					Text("•")
						.scalableFont(.subtitle)
						.colorInvert()
					Text(bullet)
						.scalableFont(.subtitle)
						.colorInvert()
				}
			}
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
	}
}
