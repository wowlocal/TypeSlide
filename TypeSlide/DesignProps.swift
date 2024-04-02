//
//  DesignProps.swift
//  TypeSlide
//
//  Created by Misha Nya on 31.03.2024.
//

import Foundation
import SwiftUI

struct AppSizes {
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
	let size: CGFloat
	let weight: Font.Weight
	let design: Font.Design

	static var statement: AppFont {
		AppFont(size: AppSizes.statementFont,
				weight: AppFontWeights.titleWeight,
				design: AppFontDesigns.titleDesign)
	}

	// Title font
	static var title: AppFont {
		AppFont(size: AppSizes.titleFont, 
				weight: AppFontWeights.titleWeight,
				design: AppFontDesigns.titleDesign)
	}

	// Subtitle font
	static var subtitle: AppFont {
		AppFont(size: AppSizes.subtitleFont, 
				weight: AppFontWeights.subtitleWeight,
				design: AppFontDesigns.defaultDesign)
	}

	// Body font
	static var body: AppFont {
		AppFont(size: AppSizes.bodyFont, 
				weight: AppFontWeights.bodyWeight,
				design: AppFontDesigns.bodyDesign)
	}

	// Caption font
	static var caption: AppFont {
		AppFont(size: AppSizes.captionFont, 
				weight: AppFontWeights.captionWeight,
				design: AppFontDesigns.defaultDesign)
	}
}

extension View {
	func scalableFont(_ font: AppFont) -> some View {
		self.modifier(ScalableFontModifier(font: font))
	}
}

struct ScalableFontModifier: ViewModifier {
	var font: AppFont

	@Environment(\.scaleFactor) var scaleFactor: CGFloat

	func body(content: Content) -> some View {
		content.font(
			.system(size: font.size * scaleFactor, weight: font.weight, design: font.design)
		)
	}
}

struct ScalablePaddingModifier: ViewModifier {
	@Environment(\.scaleFactor) var scaleFactor: CGFloat

	var edges: Edge.Set = .all
	var length: CGFloat? = nil

	func body(content: Content) -> some View {
		content.padding(edges, length ?? 20 * scaleFactor)
	}
}

extension View {
	func scalablePadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
		self.modifier(ScalablePaddingModifier(edges: edges, length: length))
	}
}
