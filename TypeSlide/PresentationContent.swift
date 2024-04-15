//
//  PresentationContent.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

// not index
let initialSlize = 37
let codeSamplesToWarmUp: [KeyPath<Samples, String>] = [
	\.identity1,
	 \.identity0,
	 \.rectSome,
	 \.rectAny,
	 \.rectExplicitIdentity,
	 \.impossibleAnyView,
	 \.possibleAnyView0,
	 \.possibleAnyView1,
	 \.possibleAnyView2,
	 \.transitionSymmetricIntro0,
	 \.transitionSymmetricIntro1,
	 \.transitionSymmetric,
	 \.transitionAsymmetric,
	 \.transitionBouncy,
	 \.timingCurveAnimate0,
	 \.timingCurveAnimate1,
	 \.timingCurveAnimate2,
	 \.springAnimate0,
	 \.springAnimate1,
	 \.springAnimate2,
	 \.notSpringAnimate,
	 \.higherOrderAnimate,
	 \.customAnimationProtocol0,
	 \.customAnimationProtocol1,
	 \.customAnimationProtocol2,
]

let slides: [SlideType] = [
	.title("SwiftUI анимации", subtitle: "От основ к продвинутым практикам"), // 1
	// --------------------------------------------------------------- //
	.identitySample0, // 2
	.identitySample1, // 3
	.rectSome, // 4
	.rectAny, // 5
	// --------------------------------------------------------------- //
	.statement(title: "Strutural Identity"), // 6
	.statement(title: "Strutural Identity", subtitle: "А как насчет explicit identity"), // 7
	.rectExplicitId, // 8
	.hipsterStatement("Типизация играет ключевую роль в определении identity"), // 9
	// --------------------------------------------------------------- //
	.impossibleAnyView, // 10
	.statement(title: "", subtitle: "some View -> any View"), // 11
	.possibleAnyView, // 12
	.bullets(title: "AnyView", // 13
			 bullets: [
				"Makes code harder to understand",
				"Fewer compile-time diagnostics",
				"Worse performance when not needed",
			 ]),
	.hipsterStatement("Not Recommended"), // 14
	// --------------------------------------------------------------- //
	.title(".transition", subtitle: "Анимации появления и исчезновения"), // 15
	.transitionIntro, // 16
	.transitionSymmetric, // 17
	.transitionAsymmetric, // 18
	.statement(title: "Добавим специй"), // 19
	.statement(title: "Добавим специй", subtitle: ".bouncy() .combined(with: .opacity)"), // 20
	.transitionBouncy, // 21
	// --------------------------------------------------------------- //
	.title(".animation", subtitle: "Функции анимирования"), // 22
	.bullets(title: "Animation taxonomy",
			 bullets: [
				"Timing curve",
				"Spring",
				"Higher order animations",
			 ]),
	.timingCurveAnimate0, // 23
	.timingCurveAnimate1, // 24
	.springAnimate0, // 26
	.timingCurveAnimate2, // bouncy
	.springAnimate1, // 27
	.springAnimate2,
	.notSpringAnimate,
	.higherOrderAnimate,
	.bullets(title: "Вывод",
			 bullets: [
				"Spring для интерактивных элементов",
				"Linear для прогресс индикаторов",
				"EaseInOut отстой",
			 ]),
	// --------------------------------------------------------------- //
	.hipsterStatement("но если этого мало..."),
	.statement(title: "CustomAnimation", subtitle: "вам не пригодится"),
	.customAnimationProtocol,
	.statement(title: "Не будем тратить время"),
	.statement(title: "", subtitle: "Погнали к keyframed анимациям"),
	// --------------------------------------------------------------- //
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
		case .identitySample0:
			codeSample0
		case .identitySample1:
			code(codeSample1, substeps: true)
		case .rectSome:
			rectSomePreview
		case .rectAny:
			code(rectAnyPreview, substeps: true)
		case .rectExplicitId:
			rectExplicitId
		case .impossibleAnyView:
			impossibleAnyView
		case .possibleAnyView:
			code(possibleAnyView)
		case .transitionIntro:
			code(transitionSymmetricIntro)
		case .transitionSymmetric:
			transitionSymmetric
		case .transitionAsymmetric:
			transitionAsymmetric
		case .transitionBouncy:
			transitionBouncy
		case .timingCurveAnimate0:
			timingCurveAnimate0
		case .timingCurveAnimate1:
			timingCurveAnimate1
		case .timingCurveAnimate2:
			timingCurveAnimate2
		case .springAnimate0:
			springAnimate0
		case .springAnimate1:
			springAnimate1
		case .springAnimate2:
			springAnimate2
		case .notSpringAnimate:
			notSpringAnimate
		case .higherOrderAnimate:
			higherOrderAnimate
		case .customAnimationProtocol:
			code(customAnimationProtocol)
		}
	}
}

enum SlideType {
	case title(String, subtitle: String)
	case hipsterStatement(String)
	case statement(title: String, subtitle: String = "")
	case bullets(title: String, bullets: [String])
	case identitySample0
	case identitySample1
	case rectSome
	case rectAny
	case rectExplicitId
	case impossibleAnyView
	case possibleAnyView
	case transitionIntro
	case transitionSymmetric
	case transitionAsymmetric
	case transitionBouncy
	case timingCurveAnimate0
	case timingCurveAnimate1
	case timingCurveAnimate2
	case springAnimate0
	case springAnimate1
	case springAnimate2
	case notSpringAnimate
	case higherOrderAnimate
	case customAnimationProtocol
}
