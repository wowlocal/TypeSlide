//
//  TypeSlideApp.swift
//  TypeSlide
//
//  Created by Misha Nya on 30.03.2024.
//

import SwiftUI

struct PrewviewView: View {
	var body: some View {
		TabView {
//			SlideView {
//				TitleAndBulletsSlide(title: "Key Points", bullets: ["Point One", "Point Two", "Point Three"])
//					.previewDisplayName("Title and Bullets Slide")
//			}
//			SlideView {
//				TitleSlide(title: "Presentation Title")
//					.previewDisplayName("Title Slide")
//			}
			SlideView {
				StatementSlide(statement: "SwiftUI makes UI development incredibly efficient.")
					.previewDisplayName("Statement Slide")
			}
			SlideView {
				TitleSubtitleClassic(title: "Welcome to SwiftUIKeynoteClone", subtitle: "This is a simple slide.")
			}
		}
		.background(Color.gray)
	}
}

enum SlideType {
	case title(String)
	case statement(String)
	case titleSubtitle(title: String, subtitle: String = "")
	case bullets(title: String, bullets: [String])
}

protocol Slidable {
	var substep: Int { get set }
	var numberOfSubsteps: Int { get }
}

class PresentationManager: ObservableObject {
	@Published var slides: [SlideType]
	@Published var currentIndex: Int = 0

	@Published var substep: Int = 0

	var slideSubstepLimit: Int = 0

	init(_ slides: [SlideType]) {
		self.slides = slides
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
		.titleSubtitle(title: "Hello"),
		.titleSubtitle(title: "Hello", subtitle: "World"),
		.title("Foo"),
		.bullets(title: "Foo", bullets: ["1", "2"]),
		.statement("statement"),
	])

	@Namespace var animation

	func bulletsSlide(_ title: String, _ bullets: [String]) -> TitleAndBullets {
		let bullets = TitleAndBullets(
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
		case .title(let title):
			TitleText(title: title, animation: animation)
		case .statement(let title):
			TitleText(title: title, animation: animation)
		case .titleSubtitle(let title, let subtitle):
//			TitleSubtitleClassic(title: title, subtitle: subtitle)
			TitleSubtitleModern(title: title, subtitle: subtitle)
		}
	}

	var body: some View {
		VStack(spacing: 0) {
			SlideView {
				slide
			}
			.animation(.smooth, value: presentationManager.currentIndex)
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
		}
	}
}


let defaultSlide = Presentation()

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

import AppKit

@main
struct TypeSlideApp: App {

    var body: some Scene {
		WindowGroup {
			// defaultSlide
			/*HStack {
				Spacer()
				WhatIsIdentityView()
				Spacer()
				SwiftCodeHighlightView(code: """
					 @ViewBuilder
					 var try3: some View {
						 if toggle {
							 //View1().id(2)
							 Color.red.frame(width: 300, height: 300)
						 } else {
							 //View2().id(2)
							 Color.green.frame(width: 200, height: 200)
						 }
					 }
					""")
			}*/
			Presentation()
				.padding([.top, .bottom], 30)
				.ignoresSafeArea(.all)
				.frame(minWidth: 500, maxWidth: .infinity, minHeight: 500 / (16 / 9), maxHeight: .infinity)
				.background(TransparentWindow().ignoresSafeArea(.all))
        }
		.windowStyle(HiddenTitleBarWindowStyle())
		.windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
		.windowResizability(.contentSize)

    }
}

struct TransparentWindow: NSViewRepresentable
{
	func updateNSView(_ nsView: NSView, context: Context) {}

	func makeNSView(context: Self.Context) -> NSView {
		let view = NSVisualEffectView()
		view.material = .hudWindow
		view.blendingMode = .behindWindow
		return view
	}
}
