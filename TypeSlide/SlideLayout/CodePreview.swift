//
//  CodePreview.swift
//  TypeSlide
//
//  Created by Misha Nya on 13.04.2024.
//

import SwiftUI
import HighlightSwift

struct CodePreview<Preview: View>: View {
	var code: KeyPath<Samples, String>
	@Environment(\.codeSamples) var codeSamples
	@ViewBuilder var preview: Preview // TODO: public init(@ViewBuilder content: () -> Content)

	var body: some View {
		HStack(alignment: .center) {
			SwiftCodeHighlightView(code: codeSamples.colored[code] ?? "")
			preview
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct Samples {
	let identity1 = """
 @State var toggle: Bool
"""

	var colored: [KeyPath<Samples, String>: AttributedString] = [:]

	@MainActor mutating func update(_ kp: KeyPath<Samples, String>, 
									with sample: AttributedString) {
		colored[kp] = sample
	}
}

struct SamplesEnvironmentKey: EnvironmentKey {
	static let defaultValue: Samples = .init()
}

extension EnvironmentValues {
	var codeSamples: Samples {
		get { self[SamplesEnvironmentKey.self] }
		set { self[SamplesEnvironmentKey.self] = newValue }
	}
}

var codeSample1: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentityView()
	}
}
