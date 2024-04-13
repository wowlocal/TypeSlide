//
//  CodePreview.swift
//  TypeSlide
//
//  Created by Misha Nya on 13.04.2024.
//

import SwiftUI
import HighlightSwift

struct CodePreview<Preview: View>: View {
	var code: String
	var preview: Preview

	var body: some View {
		HStack(alignment: .center) {
			SwiftCodeHighlightView(code: code)
			preview
			// Color.red.frame(width: 300, height: 300)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

