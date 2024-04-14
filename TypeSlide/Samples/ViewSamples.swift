//
//  ViewSamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import SwiftUI

struct Samples {
	var colored: [KeyPath<Samples, String>: AttributedString] = [:]

	@MainActor mutating func update(_ kp: KeyPath<Samples, String>,
									with sample: AttributedString) {
		colored[kp] = sample
	}
}

// --------------------------------------------------------------- //

var codeSample0: CodePreview<some View> {
	CodePreview(code: \.identity0) {
		WhatIsIdentity0()
	}
}

var codeSample1: CodePreview<some View> {
	CodePreview(code: \.identity1) {
		WhatIsIdentity1()
	}
}

// --------------------------------------------------------------- //

var rectSomePreview: CodePreview<some View> {
	CodePreview(code: \.rectSome) {
		RectSomePreview()
	}
}

var rectAnyPreview: CodePreview<some View> {
	CodePreview(code: \.rectAny) {
		RectAnyPreview()
	}
}

var rectExplicitId: CodePreview<some View> {
	CodePreview(code: \.rectExplicitIdentity) {
		RectExplicitId()
	}
}

var impossibleAnyView: JustCode {
	JustCode(code: \.impossibleAnyView)
}

var possibleAnyView: JustCode {
	JustCode(code: [
		\.possibleAnyView0,
		\.possibleAnyView1,
		\.possibleAnyView2,
	])
}

// --------------------------------------------------------------- //

var codeSample4: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentity1()
	}
}

var codeSample5: CodePreview<some View> {
	//CodePreview(preview: Color.red.frame(width: 300, height: 300), code: sample1)
	CodePreview(code: \.identity1) {
		WhatIsIdentity1()
	}
}
