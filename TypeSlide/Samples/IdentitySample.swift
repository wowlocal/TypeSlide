//
//  IdentitySample.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation
import SwiftUI

struct View1: View {
	var body: some View {
		Color.green.frame(width: 200, height: 200).id("1")
	}
}

struct View2: View {
	var body: some View {
		Color.orange.frame(width: 300, height: 300).id("1")
	}
}

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


/*
 Button("animate") {
	 withAnimation {
		 animate.toggle()
	 }
 }.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])



 var size: CGFloat {
		toggle ? 300 : 200
	}

	var correctlyAnimating: Color {
		toggle ? .orange : .green
	}

	var try2: some View {
		if toggle {
			//View1().id(2)
			Color.orange.frame(width: 300, height: 300)//.id("1")
		} else {
			//View2().id(2)
			Color.green.frame(width: 200, height: 200)//.id("1")
		}
	}

	@ViewBuilder
	var try4: some View {
		if toggle {
			View1()
		} else {
			View2()
		}
	}

	@ViewBuilder
	var try3: some View {
		if toggle {
			Color.orange
				.frame(width: 300, height: 300)
		} else {
			Color.green
				.frame(width: 200, height: 200)
		}
	}
 */
