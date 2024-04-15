//
//  AnimationTaxonomySamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 15.04.2024.
//

import SwiftUI

struct AnimateCircle: View {
	@State var trigger = false

	let animation: Animation

	var body: some View {
		VStack {
			Circle()
				.opacity(trigger ? 1.0 : 0.5)
				.animation(animation, value: trigger)

			Circle()
				.opacity(trigger ? 1.0 : 0.5)
				.animation(animation, value: trigger)

			Button("Toggle") {
				trigger.toggle()
			}
		}
	}
}


struct SpringExample: View {

	@State var toggle: Bool = true

	var body: some View {
		VStack {
			SpringSnakeShape()
				.stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
				.foregroundColor(.white)
				.frame(height: toggle ? 150 : 500)
				.overlay(
					RoundedRectangle(cornerRadius: 25)
						.fill(Color.white)
						.frame(width: 150, height: 300)
						.offset(x: 0, y: 290), // Adjust this to position the rectangle correctly
					alignment: .bottom
				)
			Spacer()
		}
		.overlay(
			Button("animate") {
				withAnimation {
					toggle.toggle()
				}
			}
			.opacity(0)
			.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])		)
	}
}

struct SpringSnakeShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Starting point for the path
		let start = CGPoint(x: rect.midX, y: rect.minY)
		path.move(to: start)

		// Number of waves in the snake-like spring
		let numberOfWaves = 4
		// Calculate the height of each wave
		let waveHeight = rect.height / CGFloat(numberOfWaves)
		// Amplitude of the waves (horizontal shift of the curves)
		let amplitude = rect.width / 3

		// Define initial control points for smoother start
		var currentPoint = start

		// Create the wave-like pattern using a smoother transition approach
		for i in 1...numberOfWaves {
			let yCoord = start.y + CGFloat(i) * waveHeight
			let right = (i % 2 == 0)
			let controlPoint = CGPoint(x: currentPoint.x + (right ? amplitude : -amplitude), y: currentPoint.y + waveHeight / 2)
			let endPoint = CGPoint(x: start.x, y: yCoord)

			// Add quadratic bezier curve to the path for smoother transitions
			path.addQuadCurve(to: endPoint, control: controlPoint)

			// Update current point for the next curve
			currentPoint = endPoint
		}

		return path
	}
}

struct SpringAngledShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Start from the top center of the bounding box
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))

		// Control points and segment settings for a smoother spring
		let segmentCount = 6
		let segmentLength = rect.height / CGFloat(segmentCount)
		let amplitude = rect.width / 3
		let controlDistance = segmentLength / 3  // Adjust this to modify the smoothness

		for i in 0..<segmentCount {
			let xPosition = rect.midX + (i % 2 == 0 ? amplitude : -amplitude)
			let yPosition = rect.minY + CGFloat(i + 1) * segmentLength
			let controlPoint1 = CGPoint(x: rect.midX + (i % 2 == 0 ? amplitude/3 : -amplitude/3), y: rect.minY + CGFloat(i) * segmentLength + controlDistance)
			let controlPoint2 = CGPoint(x: xPosition - (i % 2 == 0 ? amplitude/3 : -amplitude/3), y: yPosition - controlDistance)

			// Add a cubic Bezier curve to the path
			path.addCurve(to: CGPoint(x: xPosition, y: yPosition), control1: controlPoint1, control2: controlPoint2)
		}

		// Ensure a smooth curve for the final segment
		let finalControl1 = CGPoint(x: rect.midX + (-amplitude/3), y: rect.maxY - controlDistance)
		let finalControl2 = CGPoint(x: rect.midX, y: rect.maxY)
		path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control1: finalControl1, control2: finalControl2)

		return path
	}
}
