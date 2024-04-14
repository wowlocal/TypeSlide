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

	var showAsSubsteps: Bool = false

	var numberOfSubsteps: Int {
		return showAsSubsteps ? 1 : 0
	}

	@Binding var substep: Int

	init(code: KeyPath<Samples, String>, @ViewBuilder preview: () -> Preview) {
		self.code = code
		self.preview = preview()
		self._substep = .constant(0)
	}

	var showPreview: Bool {
		return substep == 1
	}

	var body: some View {
		HStack(alignment: .center) {
			SwiftCodeHighlightView(code: codeSamples.colored[code] ?? "")
				.padding(.leading, 60)
			Spacer()
			if showPreview { preview }
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

	func showAs(substeps: Bool) -> Self {
		var copy = self
		copy.showAsSubsteps = substeps
		return copy
	}

	func setClicker(_ binding: Binding<Int>) -> Self {
		var copy = self
		copy._substep = binding
		return copy
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
//		Color.clear
	}
}

var codeSample2: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentityView()
	}
}

var codeSample3: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentityView()
	}
}

var codeSample4: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentityView()
	}
}

var codeSample5: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentityView()
	}
}
