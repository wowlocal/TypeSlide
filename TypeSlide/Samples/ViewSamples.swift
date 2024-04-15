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

var transitionSymmetricIntro: JustCode {
	JustCode(code: [
		\.transitionSymmetricIntro0,
		\.transitionSymmetricIntro1,
	])
}

var transitionSymmetric: CodePreview<some View> {
	CodePreview(code: \.transitionSymmetric) {
		TransitionSymmetric()
	}
}

var transitionAsymmetric: CodePreview<some View> {
	CodePreview(code: \.transitionAsymmetric) {
		TransitionAsymmetric()
	}
}

var transitionBouncy: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		TransitionAsymmetricBouncy()
	}
}

// --------------------------------------------------------------- //

var timingCurveAnimate0: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		SpringExample()
		//AnimateCircle(animation: .easeIn)
	}
}

var timingCurveAnimate1: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		AnimateCircle(animation: .easeIn)
	}
}

var timingCurveAnimate2: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		AnimateCircle(animation: .easeInOut)
	}
}

var springAnimate0: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		AnimateCircle(animation: .spring)
	}
}

var springAnimate1: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		AnimateCircle(animation: .easeIn)
	}
}

var higherOrderAnimate0: CodePreview<some View> {
	CodePreview(code: \.higherOrderAnimate0) {
		AnimateCircle(animation: .easeIn)
	}
}

var higherOrderAnimate1: CodePreview<some View> {
	CodePreview(code: \.higherOrderAnimate1) {
		AnimateCircle(animation: .easeIn)
	}
}
