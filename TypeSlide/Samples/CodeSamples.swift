//
//  CodeSamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

extension Samples {

	var identity0: String { """
@State var toggle: Bool

 var body: some View {
	 Color.orange
		 .frame(width: toggle ? 300 : 200)
 }
""" }

	var identity1: String { """
@State var toggle: Bool

var body: some View {
 if toggle {
  Color.orange
   .frame(width: 300, height: 300)
 } else {
  Color.green
   .frame(width: 200, height: 200)
 }
}
""" }

	// --------------------------------------------------------------- //

	var rectSome: String { """
var color: some View {
	if toggle {
		Color.orange.frame(width: 300, height: 300)
	} else {
		Color.green.frame(width: 200, height: 200)
	}
}

var body: some View { color }
""" }

	var rectAny: String { """
@ViewBuilder
var color: some View {
	if toggle {
		Color.orange.frame(width: 300, height: 300)
	} else {
		Color.green.frame(width: 200, height: 200)
	}
}

var body: some View { color }
""" }

	var rectExplicitIdentity: String { """
@ViewBuilder
var color: some View {
	if toggle {
		Color.orange.id(1337)
	} else {
		Color.green.id(1337)
	}
}
""" }

	// --------------------------------------------------------------- //

	var impossibleAnyView: String { """
struct Green: View { var body: some View { Color.green } }
struct Orange: View { var body: some View { Color.orange } }

...

!!! error: Branches have mismatching types 'Green' and 'Orange' !!!

var color: some View {
	if toggle {
		Green()
	} else {
		Orange()
	}
}
""" }

	// --------------------------------------------------------------- //

	var possibleAnyView0: String { """
struct Green: View { var body: some View { Color.green } }
struct Orange: View { var body: some View { Color.orange } }

...

var color: any View {
	if toggle {
		Green()
	} else {
		Orange()
	}
}
""" }

	var possibleAnyView1: String { """
!!! error: Branches have mismatching types 'Green' and 'Orange' !!!
var body: some View { color }

var color: any View {
	if toggle {
		Green()
	} else {
		Orange()
	}
}
""" }

	var possibleAnyView2: String { """
var body: some View { AnyView(color) }

var color: any View {
	if toggle {
		Green()
	} else {
		Orange()
	}
}
""" }

	// --------------------------------------------------------------- //

	var transitionSymmetricIntro0: String { """
@ViewBuilder
var color: some View {
	if toggle {
		Color.orange.frame(width: 300, height: 300)
	} else {
		Color.green.frame(width: 200, height: 200)
	}
}

var body: some View { color }
""" }

	var transitionSymmetricIntro1: String { """
var body: some View { color }
""" }

	var transitionSymmetric: String { """
var body: some View { 
	color
		.transition(.slide)
}
""" }

	var transitionAsymmetric: String { """
var body: some View {
	color.transition(.asymmetric(
		insertion: .offset(degrees: -45),
		removal: .offset(degrees: 90)
	))
}
""" }

	var transitionBouncy: String { """
var body: some View {
	color
		.animation(
			.bouncy(duration: 0.4, extraBounce: 0.2)
		)
		.transition(
			.asymmetric(...)
			.combined(with: .opacity)
		)
}
""" }

	var timingCurveAnimate0: String { """
""" }

	var timingCurveAnimate1: String { """
""" }

	var timingCurveAnimate2: String { """
""" }

	var springAnimate0: String { """
""" }

	var springAnimate1: String { """
""" }

	var higherOrderAnimate0: String { """
""" }

	var higherOrderAnimate1: String { """
""" }

}
