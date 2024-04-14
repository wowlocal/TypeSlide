//
//  CodePreview.swift
//  TypeSlide
//
//  Created by Misha Nya on 13.04.2024.
//

import SwiftUI
import HighlightSwift

struct JustCode: View {
	var samples: [KeyPath<Samples, String>]
	@Binding var substep: Int

	var numberOfSubsteps: Int {
		samples.count - 1
	}

	init(code: KeyPath<Samples, String>) {
		samples = [code]
		self._substep = .constant(0)
	}

	init(code samples: [KeyPath<Samples, String>]) {
		self.samples = samples
		self._substep = .constant(0)
	}

	@Environment(\.codeSamples) var codeSamples

	var body: some View {
		SwiftCodeHighlightView(
			code: codeSamples.colored[
				samples[substep]
			] ?? ""
		)
	}

	func setClicker(_ binding: Binding<Int>) -> Self {
		var copy = self
		copy._substep = binding
		return copy
	}
}

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
		self._substep = .constant(1)
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
