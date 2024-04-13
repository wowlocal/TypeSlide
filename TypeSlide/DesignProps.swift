//
//  DesignProps.swift
//  TypeSlide
//
//  Created by Misha Nya on 31.03.2024.
//

import Foundation
import SwiftUI

struct AppSizes {
	static let superTitleFont: CGFloat = 188
	static let superSubtitleFont: CGFloat = 122

	static let statementFont: CGFloat = 116
	static let titleFont: CGFloat = 85
	static let subtitleFont: CGFloat = 55
	static let bodyFont: CGFloat = 48
	static let captionFont: CGFloat = 36

	// Spacing and dimensions
	static let standardPadding: CGFloat = 16
	static let cornerRadius: CGFloat = 10
}

struct AppFontDesigns {
	static let defaultDesign: Font.Design = .default // SF Pro
	static let titleDesign: Font.Design = .default
	static let bodyDesign: Font.Design = .serif
	// Add more as needed...
}

struct AppFontWeights {
	static let titleWeight: Font.Weight = .bold
	static let subtitleWeight: Font.Weight = .semibold
	static let bodyWeight: Font.Weight = .regular
	static let captionWeight: Font.Weight = .light
	// Add more as needed...
}

struct AppFont {
	var size: CGFloat
	let weight: Font.Weight
	let design: Font.Design

	static var code: AppFont {
		AppFont(size: 36,
				weight: .regular,
				design: .monospaced)
	}

	static var statement: AppFont {
		AppFont(size: 116,
				weight: .bold,
				design: .serif)
	}

	// Title font
	static var title: AppFont {
		AppFont(size: AppSizes.titleFont,
				weight: AppFontWeights.titleWeight,
				design: AppFontDesigns.titleDesign)
	}

	static var ultraTitle: AppFont {
		AppFont(size: 190,
				weight: .heavy,
				design: .rounded)
	}

	static var modernTitle: AppFont {
		AppFont(size: 90,
				weight: .bold,
				design: .default)
	}

	static var superTitle: AppFont {
		AppFont(size: 160,
				weight: .heavy,
				design: .default)
	}

	static var superSubtitle: AppFont {
		AppFont(size: 100,
				weight: .bold,
				design: AppFontDesigns.defaultDesign)
	}

	static var modernSubtitle: AppFont {
		AppFont(size: 80,
				weight: AppFontWeights.subtitleWeight,
				design: AppFontDesigns.defaultDesign)
	}

	static var subtitle: AppFont {
		AppFont(size: AppSizes.subtitleFont,
				weight: AppFontWeights.subtitleWeight,
				design: AppFontDesigns.defaultDesign)
	}

	static var bullet: AppFont {
		AppFont(size: 62,
				weight: .regular,
				design: .monospaced)
	}

	static var body: AppFont {
		AppFont(size: AppSizes.bodyFont,
				weight: AppFontWeights.bodyWeight,
				design: AppFontDesigns.bodyDesign)
	}

	static var caption: AppFont {
		AppFont(size: AppSizes.captionFont,
				weight: AppFontWeights.captionWeight,
				design: AppFontDesigns.defaultDesign)
	}
}

extension View {
	func fontStyle(_ font: AppFont) -> some View {
		self.modifier(FontModifier(font: font))
	}
}

struct FontModifier: ViewModifier {
	var font: AppFont
	// TODO: monitor environment style

	func body(content: Content) -> some View {
		content.font(
			.system(size: font.size, weight: font.weight, design: font.design)
		)
	}
}

struct C {
	static let deepPurple: Color = Color(.displayP3, red: 120/255, green: 24/255, blue: 245/255)
}
