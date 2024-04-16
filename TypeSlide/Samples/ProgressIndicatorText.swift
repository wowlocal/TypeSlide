//
//  ProgressIndicatorText.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import SwiftUI

struct ProgressIndicatorText: View {
	@State private var progress: Int = 0

	var body: some View {
		HStack {
			Text("Installing: ")
			Progress(progress: progress)
		}
		.padding(.leading, 40)
		.font(.system(size: 200))
		.fontWeight(.bold)
		.foregroundColor(.white)
		.frame(maxWidth: .infinity, alignment: .leading)
		.onAppear {
			withAnimation(Animation.easeInOut(duration: 2)) {
				self.progress = 90
			} completion: {
				withAnimation(.easeInOut(duration: 2)) {
					self.progress = 100
				} completion: {
					withAnimation(.easeIn.speed(0.2).delay(1)) { self.progress = 146 }
				}
			}
		}
	}

	struct Progress: View, Animatable {
		var progress: Int
		var animatableData: Double {
			get { Double(progress) / 100 }
			set { progress = Int(newValue * 100) }
		}

		var body: some View {
			Text("\(progress) %")
		}
	}
}


// demonstrating purpose, not recommended application of AnimatableModifier
struct TypingTextModifier: AnimatableModifier {
	var text: String
	var progress: CGFloat

	var animatableData: CGFloat {
		get { progress }
		set { progress = newValue }
	}

	struct LabelView: View {
		let text: String

		var body: some View {
			Text(text)
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.system(size: 60).monospaced())
				.foregroundColor(.white)
		}
	}

	func body(content: Content) -> some View {
		let visibleLength = Int(progress * CGFloat(text.count))
		let visibleText = String(text.prefix(visibleLength))
		return content.overlay(LabelView(text: visibleText))
	}
}

struct TypingTextView: View {
	var text: String
	@State private var typingProgress: CGFloat = 0

	var body: some View {
		Color.clear
			.modifier(TypingTextModifier(text: text, progress: self.typingProgress))
			.onAppear {
				withAnimation(.easeIn(duration: Double(text.count) * 0.05)) {
					typingProgress = 1
				}
			}
	}
}
