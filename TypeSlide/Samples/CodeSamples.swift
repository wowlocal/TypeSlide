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
withAnimation(.linear) {...}
""" }

	var timingCurveAnimate1: String { """
withAnimation(.easeInOut) {...}
""" }

	var timingCurveAnimate2: String { """
withAnimation(.bouncy) {...}
""" }

	var springAnimate0: String { """
withAnimation(.spring) {...}
""" }

	var springAnimate1: String { """
Circle()
	.position(position)
	.animation(.spring)
	.gesture(.onChanged { 
		self.position = $0.location 
	})
""" }

	var springAnimate2: String { """
.interpolatingSpring(
	stiffness: 80, damping: 8
)
""" }

	var notSpringAnimate: String { """
.easeInOut
""" }

	var higherOrderAnimate: String { """
// Changes the duration of an animation by adjusting its speed
.speed()
// Delays the start of the animation by the specified number of seconds
.delay()
// Repeats the animation for a specific number of times
.repeatCount(:autoreverses:)
// Repeats the animation for the lifespan of the view
.repeatForever(autoreverses:)
""" }

	// --------------------------------------------------------------- //

	var customAnimationProtocol0: String { """
func animate<V>(
	value: V,
	time: TimeInterval,
	context: inout AnimationContext<V>
) -> VectorArithmetic
""" }

	var customAnimationProtocol1: String { """
func shouldMerge<V>(
	previous: Animation,
	value: V,
	time: TimeInterval,
	context: inout AnimationContext<V>
) -> Bool
""" }

	var customAnimationProtocol2: String { """
func velocity<V>(
	value: V,
	time: TimeInterval,
	context: AnimationContext<V>
) -> VectorArithmetic?
""" }

	// --------------------------------------------------------------- //

	var keyframe0: String { """
	 KeyframeTrack(\\.ffsetY) {
		 CubicKeyframe(10, duration: 0.15)
		 SpringKeyframe(-100, duration: 0.3, spring: .bouncy)
		 CubicKeyframe(-100, duration: 0.45)
		 SpringKeyframe(0, duration: 0.3, spring: .bouncy)
	 }
""" }

	var keyframe1: String { """
	KeyframeTrack(\\.scale) {
	  CubicKeyframe(0.9, duration: 0.15)
	  CubicKeyframe(1.2, duration: 0.3)
	  CubicKeyframe(1.2, duration: 0.3)
	  CubicKeyframe(1, duration: 0.3)
	}
""" }

	var keyframe2: String { """
	 KeyframeTrack(\\.rotation) {
		 CubicKeyframe(.zero, duration: 0.15)
		 CubicKeyframe(.zero, duration: 0.3)
		 CubicKeyframe(.init(degrees: -10), duration: 0.1)
		 CubicKeyframe(.init(degrees: 10), duration: 0.1)
		 CubicKeyframe(.init(degrees: -10), duration: 0.1)
		 CubicKeyframe(.init(degrees: 0), duration: 0.15)
	 }
""" }


	var keyframeAll: String { """
.keyframeAnimator() { view, frame in
	view
		.scaleEffect(frame.scale)
		.rotationEffect(frame.rotation, anchor: .bottom)
		.offset(y: frame.offsetY)
} keyframes: { _ in
	 KeyframeTrack(\\.offsetY) { ... }
	 KeyframeTrack(\\.scale) { ... }
	 KeyframeTrack(\\.rotation) { ... }
}
""" }

	var animatableText0: String { """
var progress: Double

var animatableData: Double {
 get { progress }
 set { progress = newValue }
}
...
let visibleLength = progress * text.count
let visibleText = text.prefix(visibleLength)
""" }

	var animatableText1: String { """
 struct Progress: View, Animatable {
	 var progress: Int
	 var animatableData: Double {
		 get { Double(progress) / 100 }
		 set { progress = Int(newValue * 100) }
	 }

	 var body: some View {
		 Text("\\(progress) %")
	 }
 }
...
withAnimation(.easeInOut(duration: 2)) {
   progress = 90
}
""" }

	var metalShowcaseLayerEffect: String { """
body
	.layerEffect(
		ShaderLibrary.pixelate(.float(progress)),
		maxSampleOffset: .zero
	)
""" }

	var metalShowcase: String { """
[[ stitchable ]] half4 pixelate(
	float2 position,
	SwiftUI::Layer layer,
	float width
) {
		layer.sample(width * round(position / width));
}
""" }

	// --------------------------------------------------------------- //

	var frutiaPreconditionClosed: String { """
var body: some View {
	Image()
		.resizable()
		.scaleEffect(0.4)
		.frame(width: 200)
		.aspectRatio(1)
		.clipShape(RoundedRectangle())
}
""" }

	var frutiaPreconditionOpened: String { """
var body: some View {
	Image()
		.frame(width: 500)
		.aspectRatio(0.75)
		.clipShape(RoundedRectangle())
}
""" }

	var frutiaPreconditionOpenedClosedCombined: String { """
@State var opened: Bool

var body: some View {
	Image()
		.frame(width: opened ? 500 : 200)
		.aspectRatio(opened ? 0.75 : 1)
		.scaleEffect(opened ? 1 : 0.4)
}
""" }

	// --------------------------------------------------------------- //

	var matchedGeometryFunc: String { """
func matchedGeometryEffect(
	id: ID, in: Namespace.ID,
	properties: MatchedGeometryProperties,
	isSource: Bool = true
)
""" }

	var matchedGeometryProperties: String { """
struct MatchedGeometryProperties : OptionSet {
	static let position: Self
	static let size: Self
	static let frame: Self
}
""" }

	var frutiaAnimateCode: String { """
@Namespace var namespace
@State var selectedItm: Item?

var body: some View {
	ZStack {
		ForEach(items) {
			Thumbnail($0)
				.matchedGeometryEffect(
				 id: $0.id,
				 in: namespace,
				 isSource: true
			  )
		}
		Details(selectedItm)
			.matchedGeometryEffect(
			 id: selected.id,
			 in: namespace,
			 isSource: true
			)
	}
}
""" }

	var frutiaAnimateDontMatchGeometry: String { """
@Namespace var namespace
@State var selectedItm: Item?
var selected: Bool { selectedItm != nil }

var body: some View {
	ZStack {
		ForEach(items) {
			Thumbnail($0)
		}
		Details(selected)
			.opacity(selected ? 1 : 0)
	}
}
""" }


	var frutiaAnimateCodeDontHide: String { """
animationSpeed = 0.1
disableImageScaling()
""" }

}

