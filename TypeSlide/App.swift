import SwiftUI

@testable import HighlightSwift

protocol Slidable {
	var substep: Int { get set }
	var numberOfSubsteps: Int { get }
}

class PresentationManager: ObservableObject {
	@Published var slides: [SlideType]
	@Published var currentIndex: Int = initialSlize - 1

	@Published var substep: Int = 0

	var slideSubstepLimit: Int = 0

	var slidesCount: Int {
		slides.count
	}

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
	@StateObject var presentationManager = PresentationManager(slides)

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

	// использовать для гомогенных вьюх, например можно скомпоновать несколько statement друг за другом
	// на одном слайде
	func composedSlide(_ views: [some View]) -> GenericComposedSlide<some View> {
		let composed = GenericComposedSlide(substep: $presentationManager.substep, views: views)
		presentationManager.slideSubstepLimit = composed.numberOfSubsteps
		return composed
	}

	func code(_ prewview: CodePreview<some View>, substeps: Bool = false) -> CodePreview<some View> {
		let view = prewview.showAs(substeps: substeps)
		presentationManager.slideSubstepLimit = view.numberOfSubsteps
		return view.setClicker($presentationManager.substep)
	}

	func code(_ code: JustCode) -> JustCode {
		presentationManager.slideSubstepLimit = code.numberOfSubsteps
		return code.setClicker($presentationManager.substep)
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
				ZStack(alignment: .bottomTrailing) {
					slide
					if debug {
						Text("\(presentationManager.currentIndex + 1) / \(presentationManager.slidesCount)")
							.transaction {
								$0.animation = nil
							}
					}
				}
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
					withAnimation(nil) {
						presentationManager.previous()
					}
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
				var idx = 0
				for kp in codeSamplesToWarmUp {
					idx += 1
					let result = try await highlight.attributed(
						codeSamples[keyPath: kp],
						language: idx == metalCodeIdx ? .cPlusPlus : .swift,
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
