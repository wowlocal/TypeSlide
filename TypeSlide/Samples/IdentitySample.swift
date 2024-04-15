//
//  IdentitySample.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation
import SwiftUI

struct Green: View { var body: some View { Color.green } }
struct Orange: View { var body: some View { Color.orange } }

struct WhatIsIdentity0: View {
	@State var toggle: Bool = true
	var body: some View {
		Color.orange
			.frame(width: toggle ? 300 : 200)
			.frame(height: 300)
			.onAppear {
				withAnimation(Animation.default.delay(1.5).repeatCount(5)) {
					self.toggle.toggle()
				}
			}
	}
}

struct WhatIsIdentity1: View {
	@State var toggle: Bool = true

	var body: some View {
		Group {
			if toggle {
				Color.orange.frame(width: 300, height: 300)//.id("1")
			} else {
				Color.green.frame(width: 200, height: 200)//.id("1")
			}
		}
		.onAppear {
			withAnimation(Animation.default.delay(1.5).repeatCount(5)) {
				self.toggle.toggle()
			}
		}
	}
}

// --------------------------------------------------------------- //

struct RectSomePreview: View {
	@State var toggle: Bool = true

	var color: some View {
		if toggle {
			Color.orange.frame(width: 300, height: 300)
		} else {
			Color.green.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		color
			.onAppear {
				withAnimation(Animation.default.delay(1.5).repeatCount(5)) {
					self.toggle.toggle()
				}
			}
	}
}

struct RectAnyPreview: View {
	@State var toggle: Bool = true

	@ViewBuilder
	var color: some View {
		if toggle {
			Color.orange.frame(width: 300, height: 300)
		} else {
			Color.green.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		color
			.onAppear {
				withAnimation(Animation.default.delay(1.5).repeatCount(5)) {
					self.toggle.toggle()
				}
			}
	}
}

struct RectExplicitId: View {
	@State var toggle: Bool = true

	@ViewBuilder
	var color: some View {
		if toggle {
			Color.orange.frame(width: 300, height: 300).id(1337)
		} else {
			Color.green.frame(width: 200, height: 200).id(1337)
		}
	}

	var body: some View {
		color
			.onAppear {
				withAnimation(Animation.default.delay(1.5).repeatCount(4)) {
					self.toggle.toggle()
				}
			}
	}
}

// --------------------------------------------------------------- //

struct TransitionSymmetric: View {
	@State var toggle: Bool = true

	@ViewBuilder
	var color: some View {
		if toggle {
			Color.orange
				.frame(width: 300, height: 300)
		} else {
			Color.green
				.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		color
			.transition(.offset(CGSize(width: 800, height: 0)))
			.onAppear {
				withAnimation(Animation.default.delay(1.5).repeatCount(5)) {
					self.toggle.toggle()
				}
			}
	}
}

struct TransitionAsymmetric: View {
	@State var toggle: Bool = true

	@ViewBuilder
	var color: some View {
		if toggle {
			Color.orange
				.frame(width: 300, height: 300)
		} else {
			Color.green
				.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		ZStack {
			color
				.transition(
					.asymmetric(
						insertion: .offset(degrees: -45),
						removal: .offset(degrees: 90)
					)
				)
			Button("animate") {
				withAnimation {
					toggle.toggle()
				}
			}
			.opacity(0)
			.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
		}
	}
}

struct TransitionAsymmetricBouncy: View {
	@State var toggle: Bool = true

	@ViewBuilder
	var color: some View {
		if toggle {
			Color.orange
				.frame(width: 300, height: 300)
		} else {
			Color.green
				.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		ZStack {
			color
				.animation(.bouncy(duration: 0.4, 
								   extraBounce: 0.2),
						   value: toggle)
				.transition(
					.asymmetric(
						insertion: .offset(degrees: -45, distance: 500),
						removal: .offset(degrees: 135, distance: 500)
					).combined(with: .opacity)
				)
			Button("animate") {
				withAnimation {
					toggle.toggle()
				}
			}
			.opacity(0)
			.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
		}
	}
}


/*
 .overlay {
	 Button("animate") {
		 withAnimation {
			 toggle.toggle()
		 }
	 }
	 .opacity(0)
	 .keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
 }
 */

extension AnyTransition {
	static func offset(degrees: Double, distance: Double = 1000) -> AnyTransition {
		let angleRadians = degrees * .pi / 180

		let x = distance * cos(angleRadians)
		let y = distance * sin(angleRadians)

		return .offset(CGSize(width: x, height: y))
	}
}

