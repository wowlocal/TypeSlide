//
//  AnimationTaxonomySamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 15.04.2024.
//

import SwiftUI

struct MagnetView: View {
	var body: some View {
		VStack {
			Rectangle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [Color.red, Color.gray]),
					startPoint: .top, endPoint: .bottom)
				)
				.frame(width: 30, height: 20)
			Rectangle()
				.fill(LinearGradient(
					gradient: Gradient(colors: [Color.gray, Color.blue]),
					startPoint: .top, endPoint: .bottom)
				)
				.frame(width: 30, height: 20)
		}
		.cornerRadius(6)
		.shadow(radius: 4)
	}
}


struct MagnetizedCircleView: View {
	let positionA = CGPoint(x: 0, y: 100)
	let positionB = CGPoint(x: 0, y: 800)

	@State private var currentPosition: CGPoint = CGPoint(x: 0, y: 100)
	@State private var isDragging = false

	let animation: Animation

	var body: some View {
		ZStack {
			Circle()
				.fill(.white)
				.frame(width: 200, height: 200)
				.position(currentPosition)
				.animation(animation, value: currentPosition)
				.shadow(color: self.isDragging ? Color.blue.opacity(0.7) : Color.clear, radius: 30, x: 0, y: 0)
				.gesture(
					DragGesture()
						.onChanged { value in
							self.isDragging = true
							self.currentPosition = value.location
						}
						.onEnded { value in
							self.isDragging = false
							// Calculate which position is closer when the gesture ends
							let distanceToA = distance(from: value.location, to: positionA)
							let distanceToB = distance(from: value.location, to: positionB)
							if distanceToA < distanceToB {
								self.currentPosition = positionA
							} else {
								self.currentPosition = positionB
							}
						}
				)
			MagnetView()
				.position(positionA)
				.allowsHitTesting(false)
			MagnetView()
				.position(positionB)
				.allowsHitTesting(false)
		}
	}

	private func distance(from source: CGPoint, to destination: CGPoint) -> CGFloat {
		let xDist = source.x - destination.x
		let yDist = source.y - destination.y
		return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
	}
}

struct SpringExample: View {

	@State var toggle: Bool = true

	let animation: Animation

	var body: some View {
		VStack {
			SpringSnakeShape()
				.stroke(style: StrokeStyle(lineWidth: toggle ? 7 : 5, lineCap: .round, lineJoin: .round))
				.foregroundColor(.white)
				.frame(height: toggle ? 150 : 650)
				.frame(width: 240)
				.overlay(
					RoundedRectangle(cornerRadius: 25)
						.fill(Color.white)
						.frame(width: 150, height: 200)
						.offset(x: 0, y: 190),
					alignment: .bottom
				)
			Spacer()
		}
		.overlay(
			Button("animate") {
				withAnimation(animation) {
					toggle.toggle()
				}
			}
			.opacity(0)
			.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
		)
	}
}

struct SpringSnakeShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Starting point for the path
		let start = CGPoint(x: rect.midX, y: rect.minY)
		path.move(to: start)

		// Number of waves in the snake-like spring
		let numberOfWaves = 8
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
