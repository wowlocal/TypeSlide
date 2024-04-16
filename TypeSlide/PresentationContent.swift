//
//  PresentationContent.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

// not index
let initialSlize = 42
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
]

let slides: [SlideType] = [
	.title("SwiftUI анимации", subtitle: "От основ к продвинутым практикам"), // 1
	// --------------------------------------------------------------- //
	.shakeHand,
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
	.shakeHand,
	.hipsterStatement("Как это работает?"),
	.codeMultistep([\.keyframe0, \.keyframe1, \.keyframe2, \.keyframeAll]),
	// --------------------------------------------------------------- //
	// . animatable data ctfont showcase
	.title("Как анимировать текст?", subtitle: "зависит от контекста"),
	.progressIndicatorTextShowcase
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
}


/*
 var charLayers = [CAShapeLayer]()

 override func viewDidAppear(_ animated: Bool) {
	 super.viewDidAppear(animated)

	 for layer in self.charLayers {
		 layer.removeFromSuperlayer()
	 }

	 let stringAttributes = [ NSAttributedStringKey.font: UIFont(name: "Futura-CondensedExtraBold", size: 64.0)! ]
	 let attributedString = NSMutableAttributedString(string: "hello world", attributes: stringAttributes )
	 let charPaths = self.characterPaths(attributedString: attributedString, position: CGPoint(x: 24, y: 192))

	 self.charLayers = charPaths.map { path -> CAShapeLayer in
		 let shapeLayer = CAShapeLayer()
		 shapeLayer.fillColor = UIColor.clear.cgColor
		 shapeLayer.strokeColor = UIColor.red.cgColor
		 shapeLayer.lineWidth = 2
		 shapeLayer.path = path
		 return shapeLayer
	 }

	 for layer in self.charLayers {
		 view.layer.addSublayer(layer)
		 let animation = CABasicAnimation(keyPath: "strokeEnd")
		 animation.fromValue = 0
		 animation.duration = 2.2
		 layer.add(animation, forKey: "charAnimation")
	 }
 }

 func characterPaths(attributedString: NSAttributedString, position: CGPoint) -> [CGPath] {

	 let line = CTLineCreateWithAttributedString(attributedString)

	 guard let glyphRuns = CTLineGetGlyphRuns(line) as? [CTRun] else { return []}

	 var characterPaths = [CGPath]()

	 for glyphRun in glyphRuns {
		 guard let attributes = CTRunGetAttributes(glyphRun) as? [String:AnyObject] else { continue }
		 let font = attributes[kCTFontAttributeName as String] as! CTFont

		 for index in 0..<CTRunGetGlyphCount(glyphRun) {
			 let glyphRange = CFRangeMake(index, 1)

			 var glyph = CGGlyph()
			 CTRunGetGlyphs(glyphRun, glyphRange, &glyph)

			 var characterPosition = CGPoint()
			 CTRunGetPositions(glyphRun, glyphRange, &characterPosition)
			 characterPosition.x += position.x
			 characterPosition.y += position.y

			 if let glyphPath = CTFontCreatePathForGlyph(font, glyph, nil) {
				 var transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: characterPosition.x, ty: characterPosition.y)
				 if let charPath = glyphPath.copy(using: &transform) {
					 characterPaths.append(charPath)
				 }
			 }
		 }
	 }
	 return characterPaths
 }

 */
