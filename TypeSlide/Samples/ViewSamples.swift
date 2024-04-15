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
	CodePreview(code: \.timingCurveAnimate0) {
		SpringExample(animation: .linear)
	}
}

var timingCurveAnimate1: CodePreview<some View> {
	CodePreview(code: \.timingCurveAnimate1) {
		SpringExample(animation: .easeInOut)
	}
}

var timingCurveAnimate2: CodePreview<some View> {
	CodePreview(code: \.timingCurveAnimate2) {
		SpringExample(animation: .bouncy(extraBounce: 0.2))
	}
}

var springAnimate0: CodePreview<some View> {
	CodePreview(code: \.springAnimate0) {
		SpringExample(animation: .spring)
	}
}

var springAnimate1: CodePreview<some View> {
	CodePreview(code: \.springAnimate1) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .spring
			)
		}
	}
}

var springAnimate2: CodePreview<some View> {
	CodePreview(code: \.springAnimate2) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .interpolatingSpring(stiffness: 80, damping: 8)
			)
		}
	}
}

var notSpringAnimate: CodePreview<some View> {
	CodePreview(code: \.notSpringAnimate) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .easeInOut
			)
		}
	}
}

var higherOrderAnimate: some View {
	VStack(alignment: .leading) {
		TitleSubtitleModern(title: "", subtitle: "Higher order animations")
		Spacer()
		JustCode(code: \.higherOrderAnimate)
		Spacer()
	}
}

// --------------------------------------------------------------- //

var customAnimationProtocol: JustCode {
	JustCode(code: [
		\.customAnimationProtocol0,
		\.customAnimationProtocol1,
		\.customAnimationProtocol2,
	])
}
