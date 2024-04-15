//
//  ShakeHand.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import SwiftUI

struct Keyframe {
	var scale: CGFloat = 1
	var offsetY: CGFloat = 0
	var rotation: Angle = .zero
}

struct ShakeHand: View {
	@State private var startKeyframeAnimation: Bool = false

	var text: some View {
		Text("✋")
			.font(.system(size: 200))
	}
	var body: some View {
		VStack {
			Spacer()
			text
				.keyframeAnimator(initialValue: Keyframe(), trigger: startKeyframeAnimation) { view, frame in
					view
						.scaleEffect(frame.scale)
						.rotationEffect(frame.rotation, anchor: .bottom)
						.offset(y: frame.offsetY)
				} keyframes: { frame in
					KeyframeTrack(\.offsetY) {
						CubicKeyframe(10, duration: 0.15)
						SpringKeyframe(-100, duration: 0.3, spring: .bouncy)
						CubicKeyframe(-100, duration: 0.45)
						SpringKeyframe(0, duration: 0.3, spring: .bouncy)
					}

					KeyframeTrack(\.scale) {
						CubicKeyframe(0.9, duration: 0.15)
						CubicKeyframe(1.2, duration: 0.3)
						CubicKeyframe(1.2, duration: 0.3)
						CubicKeyframe(1, duration: 0.3)
					}

					KeyframeTrack(\.rotation) {
						CubicKeyframe(.zero, duration: 0.15)
						CubicKeyframe(.zero, duration: 0.3)
						CubicKeyframe(.init(degrees: -10), duration: 0.1)
						CubicKeyframe(.init(degrees: 10), duration: 0.1)
						CubicKeyframe(.init(degrees: -10), duration: 0.1)
						CubicKeyframe(.init(degrees: 0), duration: 0.15)
					}
				}

			Spacer()

			Button("") {
				startKeyframeAnimation.toggle()
			}
			.opacity(0)
			.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
			.fontWeight(.bold)
		}
		.padding()
	}
}
