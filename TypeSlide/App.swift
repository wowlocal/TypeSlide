//
//  TypeSlideApp.swift
//  TypeSlide
//
//  Created by Misha Nya on 30.03.2024.
//

// not index
let initialSlize = 1
let codeSamplesToWarmUp: [KeyPath<Samples, String>] = [\.identity1]

import SwiftUI

@testable import HighlightSwift

enum SlideType {
	case title(String, subtitle: String)
	case hipsterStatement(String)
	case statement(title: String, subtitle: String = "")
	case bullets(title: String, bullets: [String])
	case sample1
}

protocol Slidable {
	var substep: Int { get set }
	var numberOfSubsteps: Int { get }
}

class PresentationManager: ObservableObject {
	@Published var slides: [SlideType]
	@Published var currentIndex: Int = initialSlize - 1

	@Published var substep: Int = 0

	var slideSubstepLimit: Int = 0

	let colors: [Color]

	var slideColor: Color {
		colors[currentIndex]
	}

	init(_ slides: [SlideType]) {
		self.slides = slides
		self.colors = generateRgbColorsFunkyOrangePink(n: slides.count).map { rgb in
			Color(.displayP3, red: Double(rgb.0) / 255, green: Double(rgb.1) / 255, blue: Double(rgb.2) / 255)
		}
	}

	var currentSlide: SlideType {
		slides[max(0, min(slides.count - 1, currentIndex))]
	}

	func next() {
		if substep < slideSubstepLimit {
			substep += 1
			print("Next: Substep incremented to \(substep)")
			return
		}
		substep = 0; slideSubstepLimit = 0
		print("Next: Substep and slideSubstepLimit reset to 0")
		if currentIndex < slides.count - 1 {
			currentIndex += 1
			print("Next: Current index incremented to \(currentIndex)")
		}
	}

	func previous() {
		if substep > 0 {
			substep -= 1
			print("Previous: Substep decremented to \(substep)")
			return
		}
		substep = 0; slideSubstepLimit = 0
		print("Previous: Substep and slideSubstepLimit reset to 0")
		if currentIndex > 0 {
			currentIndex -= 1
			print("Previous: Current index decremented to \(currentIndex)")
		}
	}
}

struct Presentation: View {
	@StateObject var presentationManager = PresentationManager([
		.title("Анимации SwiftUI", subtitle: "От основ к продвинутым практикам"),
		.sample1,
		.hipsterStatement("Sound and look like notes, Make you predictable"),
		.bullets(title: "Bullet lists",
				 bullets: [
					"Increase cognitive load",
					"Look and feel robotic",
					"Are distracting",
					"Bore the hell out of everyone",
					"Make you predictable",
					"Sound and look like notes",
					"Should be notes"
				 ]),
		.hipsterStatement("statement"),
		.statement(title: "Hello", subtitle: "World"),
		.statement(title: "Hello"),
	])

	@Namespace var animation

	func bulletsSlide(_ title: String, _ bullets: [String]) -> TitleAndBulletsModern {
		let bullets = TitleAndBulletsModern(
			substep: $presentationManager.substep,
			animation: animation,
			title: title,
			bullets: bullets
		)
		presentationManager.slideSubstepLimit = bullets.numberOfSubsteps
		return bullets
	}

	@ViewBuilder
	var slide: some View {
		switch presentationManager.currentSlide {
		case .bullets(let title, let bullets):
			bulletsSlide(title, bullets)
		case .title(let title, let subtitle):
			TitleSlide(title: title, subtitle: subtitle)
		case .hipsterStatement(let title):
			StatementModern(title: title, animation: animation)
		case .statement(let title, let subtitle):
			TitleSubtitleModern(title: title, subtitle: subtitle)
		case .sample1:
			codeSample1
		}
	}

	let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
	let colors: [Color] =
	//generateRgbColorsFunkyOrangePink(n: 255)
	createColorGradient(sampleSize: 255).map { ($0[0], $0[1], $0[2]) }
		.map { rgb in
			Color(.displayP3, red: Double(rgb.0) / 255, green: Double(rgb.1) / 255, blue: Double(rgb.2) / 255)
		}
	@State private var colorIndex = 0

	@State var debug: Bool = false

	@ViewBuilder
	var debugButton: some View {
		Button(action: {
			debug.toggle()
		}) {
			Text("Toggle Button")
		}
		.frame(width: 0, height: 0)
		.opacity(0)
		.keyboardShortcut(KeyEquivalent("d"), modifiers: [.command])
	}

	@Environment(\.highlight) var highlight
	@State var codeSamples = Samples()

	var body: some View {
		VStack(spacing: 0) {
			SlideView {
				slide
			}
			.bg(color: debug ? .clear : presentationManager.slideColor)
			.onReceive(timer) { _ in
				self.colorIndex = (self.colorIndex + 1) % self.colors.count
			}
			.animation(.smooth, value: presentationManager.currentIndex)
			.background(debugButton)
			//.transition(.slide)
//			.animation(.linear(duration: 3), value: presentationManager.currentIndex)


			Group {
				Button("Previous") {
					presentationManager.previous()
				}
				.keyboardShortcut(KeyEquivalent("p"), modifiers: [.control])

				Button("Next") {
					presentationManager.next()
				}
				.keyboardShortcut(KeyEquivalent("n"), modifiers: [.control])
			}.frame(width: 0, height: 0).opacity(0)
		}.onAppear {
			Task.detached {
				// warum up cache
				for kp in codeSamplesToWarmUp {
					let result = try await highlight.attributed(
						codeSamples[keyPath: kp],
						language: .swift,
						colors: .dark(.gradient)
					)
					await MainActor.run {
						codeSamples.update(kp, with: result)
					}
					// print(result)
				}
			}
		}.environment(\.codeSamples, codeSamples)
	}
}
