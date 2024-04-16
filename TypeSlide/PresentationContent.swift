//
//  PresentationContent.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

// not index
let initialSlize = 53

let metalCodeIdx = 33
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
	 \.keyframe0, \.keyframe1, \.keyframe2, \.keyframeAll,
	 \.animatableText0, \.animatableText1,
	 \.metalShowcaseLayerEffect, \.metalShowcase,
]

let slides: [SlideType] = [
	.title("Вжух SwiftUI", subtitle: "От основ к продвинутым практикам анимирования"), // 1
	// --------------------------------------------------------------- //
	.shakeHand,
	.identitySample0, // 2
	.identitySample1, // 3
	.rectSome, // 4
	.rectAny, // 5
	// --------------------------------------------------------------- //
	.statement(title: "Структурная Идентичность"), // 6
	.statement(title: "Структурная Идентичность", subtitle: "А как насчет явной identity"), // 7
	.rectExplicitId, // 8
	.hipsterStatement("Типизация играет ключевую роль в определении identity"), // 9
	// --------------------------------------------------------------- //
	.impossibleAnyView, // 10
	.statement(title: "", subtitle: "some View -> any View"), // 11
	.possibleAnyView, // 12
	.bullets(title: "AnyView", // 13
			 bullets: [
				"Усложняет понимание кода",
				"Меньше ошибок на этапе компиляции — не всегда плюс",
				"Производительность страдает",
			 ]),
	.hipsterStatement("Not Recommended"), // 14
	// --------------------------------------------------------------- //
	.title(".transition", subtitle: "Эффектно зажечься и угаснуть"), // 15
	.transitionIntro, // 16
	.transitionSymmetric, // 17
	.transitionAsymmetric, // 18
	.statement(title: "Добавим специй"), // 19
	.statement(title: "Добавим специй", subtitle: ".bouncy() с .opacity для души"), // 20
	.transitionBouncy, // 21
	// --------------------------------------------------------------- //
	.title(".animation", subtitle: "Гармония движений"), // 22
	.bullets(title: "Ритмы анимации",
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
				"EaseInOut больше не в моде",
			 ]),
	// --------------------------------------------------------------- //
	.hipsterStatement("но если этого мало..."),
	.statement(title: "CustomAnimation", subtitle: "вам не пригодится"),
	.customAnimationProtocol,
	.statement(title: "Не будем тратить время"),
	.statement(title: "", subtitle: "Погнали к keyframed анимациям"),
	// --------------------------------------------------------------- //
	.shakeHand,
	.hipsterStatement("Как это работает?"),
	.codeMultistep([\.keyframe0, \.keyframe1, \.keyframe2, \.keyframeAll]),
	// --------------------------------------------------------------- //
	.title("Как анимировать текст?", subtitle: "зависит от контекста"),
	.progressIndicatorTextShowcase,
	.typewriterTextShowcase,
	.statement(title: "Animatable", subtitle: "сердце любой анимации"),
	.codeMultistep([\.animatableText0, \.animatableText1]),
	.hipsterStatement("Можно упороться в CTFontCreatePathForGlyph"),
	.hipsterStatement("и анимировать текст, следуя по контуру букв"),
	// --------------------------------------------------------------- //
	.title("Metal 🎸", subtitle: "главное — правильно расставить точки"),
	// --------------------------------------------------------------- //
	.codeMultistep([\.metalShowcaseLayerEffect]),
	.metalShowcase,
	.title("Комбинируя всё", subtitle: "кастомные переходы между экранами"),
	.frutiaShowcase,
	.hipsterStatement("The End")
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
		case .shakeHand:
			ShakeHand()
		case .codeMultistep(let samples):
			code(JustCode(code: samples))
		case .progressIndicatorTextShowcase:
			ProgressIndicatorText()
		case .typewriterTextShowcase:
			TypingTextView(text: "A very bad quack might jinx zippy fowls")
		case .metalShowcase:
			MetalCodeShowcase(sample: \.metalShowcase)
		case .frutiaShowcase:
			ZStack {
				JustCode(code: [
					\.customAnimationProtocol0,
					 \.customAnimationProtocol1,
					 \.customAnimationProtocol2,
				])
				.padding(.leading, -700)
				FrutiaShowcase()
			}
//			IngredientGraphic(ingredient: Ingredient.orange, style: .cardBack)
//				.frame(width: 180, height: 180)
//				.previewDisplayName("Thumbnail")
			//
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
	case shakeHand
	case codeMultistep([KeyPath<Samples, String>])
	case progressIndicatorTextShowcase
	case typewriterTextShowcase
	case metalShowcase
	case frutiaShowcase
}

