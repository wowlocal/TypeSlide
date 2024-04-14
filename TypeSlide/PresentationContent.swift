//
//  PresentationContent.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

// not index
let initialSlize = 3
let codeSamplesToWarmUp: [KeyPath<Samples, String>] = [\.identity1, \.identity0]

let slides: [SlideType] = [
	.title("SwiftUI анимации", subtitle: "От основ к продвинутым практикам"), // 1
	.sample0, // 2
	.sample1, // 3
	.sample2, // 4
	.sample3,
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
]



import SwiftUI

extension Presentation {
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
		case .sample0:
			codeSample0
		case .sample1:
			code(codeSample1, substeps: true)
		case .sample2:
			codeSample2
		case .sample3:
			codeSample3
		case .sample4:
			codeSample4
		case .sample5:
			codeSample5
		}
	}
}
