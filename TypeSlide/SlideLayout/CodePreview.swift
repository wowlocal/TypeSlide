//
//  CodePreview.swift
//  TypeSlide
//
//  Created by Misha Nya on 13.04.2024.
//

import SwiftUI
import HighlightSwift

struct CodePreview<Preview: View>: View {
	var preview: Preview
	var code: String

	var body: some View {
		HStack(alignment: .center) {
			SwiftCodeHighlightView(code: code)
			preview
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

let sample1 = """
@ViewBuilder
var try3: some View {
if toggle {
//View1().id(2)
Color.red.frame(width: 300, height: 300)
} else {
//View2().id(2)
Color.green.frame(width: 200, height: 200)
}
}
@ViewBuilder
var try3: some View {
if toggle {
//View1().id(2)
Color.red.frame(width: 300, height: 300)
} else {
//View2().id(2)
Color.green.frame(width: 200, height: 200)
}
}
@ViewBuilder
var try3: some View {
if toggle {
//View1().id(2)
Color.red.frame(width: 300, height: 300)
} else {
//View2().id(2)
Color.green.frame(width: 200, height: 200)
}
}
"""

var codeSample1: CodePreview<some View> {
	CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
}
