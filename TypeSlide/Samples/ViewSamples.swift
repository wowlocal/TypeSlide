//
//  ViewSamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import SwiftUI

struct Samples {
	var colored: [KeyPath<Samples, String>: AttributedString] = [:]

	@MainActor mutating func update(_ kp: KeyPath<Samples, String>,
									with sample: AttributedString) {
		colored[kp] = sample
	}
}

// --------------------------------------------------------------- //

var codeSample0: CodePreview<some View> {
	CodePreview(code: \.identity0) {
		WhatIsIdentity0()
	}
}

var codeSample1: CodePreview<some View> {
	CodePreview(code: \.identity1) {
		WhatIsIdentity1()
	}
}

// --------------------------------------------------------------- //

var rectSomePreview: CodePreview<some View> {
	CodePreview(code: \.rectSome) {
		RectSomePreview()
	}
}

var rectAnyPreview: CodePreview<some View> {
	CodePreview(code: \.rectAny) {
		RectAnyPreview()
	}
}

var rectExplicitId: CodePreview<some View> {
	CodePreview(code: \.rectExplicitIdentity) {
		RectExplicitId()
	}
}

var impossibleAnyView: JustCode {
	JustCode(code: \.impossibleAnyView)
}

var possibleAnyView: JustCode {
	JustCode(code: [
		\.possibleAnyView0,
		\.possibleAnyView1,
		\.possibleAnyView2,
	])
}

// --------------------------------------------------------------- //

var transitionSymmetricIntro: JustCode {
	JustCode(code: [
		\.transitionSymmetricIntro0,
		\.transitionSymmetricIntro1,
	])
}

var transitionSymmetric: CodePreview<some View> {
	CodePreview(code: \.transitionSymmetric) {
		TransitionSymmetric()
	}
}

var transitionAsymmetric: CodePreview<some View> {
	CodePreview(code: \.transitionAsymmetric) {
		TransitionAsymmetric()
	}
}

var transitionBouncy: CodePreview<some View> {
	CodePreview(code: \.transitionBouncy) {
		TransitionAsymmetricBouncy()
	}
}

// --------------------------------------------------------------- //

var timingCurveAnimate0: CodePreview<some View> {
	CodePreview(code: \.timingCurveAnimate0) {
		SpringExample(animation: .linear)
	}
}

var timingCurveAnimate1: CodePreview<some View> {
	CodePreview(code: \.timingCurveAnimate1) {
		SpringExample(animation: .easeInOut)
	}
}

var timingCurveAnimate2: CodePreview<some View> {
	CodePreview(code: \.timingCurveAnimate2) {
		SpringExample(animation: .bouncy(extraBounce: 0.2))
	}
}

var springAnimate0: CodePreview<some View> {
	CodePreview(code: \.springAnimate0) {
		SpringExample(animation: .spring)
	}
}

var springAnimate1: CodePreview<some View> {
	CodePreview(code: \.springAnimate1) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .spring
			)
		}
	}
}

var springAnimate2: CodePreview<some View> {
	CodePreview(code: \.springAnimate2) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .interpolatingSpring(stiffness: 80, damping: 8)
			)
		}
	}
}

var notSpringAnimate: CodePreview<some View> {
	CodePreview(code: \.notSpringAnimate) {
		HStack {
			Spacer(minLength: 400) // crutch
			MagnetizedCircleView(
				animation: .easeInOut
			)
		}
	}
}

var higherOrderAnimate: some View {
	VStack(alignment: .leading) {
		TitleSubtitleModern(title: "", subtitle: "Higher order animations")
		Spacer()
		JustCode(code: \.higherOrderAnimate)
		Spacer()
	}
}

// --------------------------------------------------------------- //

var customAnimationProtocol: JustCode {
	JustCode(code: [
		\.customAnimationProtocol0,
		\.customAnimationProtocol1,
		\.customAnimationProtocol2,
	])
}

// --------------------------------------------------------------- //

struct FrutiaShowcase: View {
	var smoothie: Smoothie = Smoothie(id: "papas-papaya", title: String(localized: "Papa's Papaya", comment: "Smoothie name")) {
		AttributedString(localized: "Papa would be proud of you if he saw you drinking this!", comment: "Papa's Papaya smoothie description")

		Ingredient.orange.measured(with: .cups)
	}
	@Namespace var namespace
	@State private var topmostIngredientID: Ingredient.ID?
	@State private var selectedIngredientID: Ingredient.ID?

	var content: some View {
		VStack(spacing: 0) {
			VStack(alignment: .leading) {
//				LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16, alignment: .leading)], alignment: .center, spacing: 16) {
					ForEach(smoothie.menuIngredients) { measuredIngredient in
						let ingredient = measuredIngredient.ingredient
						let presenting = selectedIngredientID == measuredIngredient.id
						Button(action: { select(ingredient: ingredient) }) {
							IngredientGraphic(ingredient: measuredIngredient.ingredient, style: presenting ? .cardFront : .thumbnail)
								.matchedGeometryEffect(
									id: measuredIngredient.id,
									in: namespace,
									isSource: !presenting
								)
								.contentShape(Rectangle())
						}
						.buttonStyle(.squishable(fadeOnPress: false))
						.aspectRatio(1, contentMode: .fit)
						.zIndex(topmostIngredientID == measuredIngredient.id ? 1 : 0)
						.accessibility(label: Text("\(ingredient.name) Ingredient",
												   comment: "Accessibility label for collapsed ingredient card in smoothie overview"))
					}
//				}.border(.red)
			}
			.padding()
		}
	}

	var container: some View {
		ZStack {
//			ScrollView {
				content
					.frame(maxWidth: 250)
					.offset(x: 200) // не нужен будет когда поместим код
			// размер карточки
					//.frame(maxWidth: .infinity)
//			}

			if selectedIngredientID != nil {
				// надо убрать падинги в SlideView
				Rectangle().fill(.ultraThinMaterial)
					.ignoresSafeArea()
					.padding(-150)
			}

			ForEach(smoothie.menuIngredients) { measuredIngredient in
				let presenting = selectedIngredientID == measuredIngredient.id
				IngredientCard(ingredient: measuredIngredient.ingredient, presenting: presenting, closeAction: deselectIngredient)
					.matchedGeometryEffect(id: measuredIngredient.id, in: namespace, isSource: presenting)
					.aspectRatio(0.75, contentMode: .fit)
					.shadow(color: Color.black.opacity(presenting ? 0.2 : 0), radius: 20, y: 10)
					.padding(20)
					.opacity(presenting ? 1 : 0)
					.zIndex(topmostIngredientID == measuredIngredient.id ? 1 : 0)
					.accessibilityElement(children: .contain)
					.accessibility(sortPriority: presenting ? 1 : 0)
					.accessibility(hidden: !presenting)
			}
		}
	}

	var body: some View {
		container
			#if os(macOS)
			.frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
			#endif
			//.background()
	}

	func select(ingredient: Ingredient) {
		topmostIngredientID = ingredient.id
		withAnimation(.openCard) {
			selectedIngredientID = ingredient.id
		}
	}

	func deselectIngredient() {
		withAnimation(.closeCard) {
			selectedIngredientID = nil
		}
	}
}
