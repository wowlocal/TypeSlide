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
		Color.green.frame(width: 200, height: 200).id("1")//.transition(.scale)
	}
}

struct View2: View {
	var body: some View {
		Color.red.frame(width: 300, height: 300).id("1")//.transition(.scale)
	}
}

struct WhatIsIdentityView: View {
	@State var toggle: Bool = true

	var size: CGFloat {
		toggle ? 300 : 200
	}

	var correctlyAnimating: Color {
		toggle ? .red : .green
	}

	var try2: some View {
		if toggle {
			//View1().id(2)
			Color.red.frame(width: 300, height: 300)//.id("1")
		} else {
			//View2().id(2)
			Color.green.frame(width: 200, height: 200)//.id("1")
		}
	}

	@ViewBuilder
	var try3: some View {
		if toggle {
			Color.red.frame(width: 300, height: 300)
		} else {
			Color.green.frame(width: 200, height: 200)
		}
	}

	var body: some View {
		VStack {
			correctlyAnimating.frame(width: size, height: size)
			try2
			try3

			Button("togglle") {
				withAnimation {
					toggle.toggle()
				}
			}
		}
	}
}

