//
//  FrutiaSample.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import SwiftUI

struct FrutiaShowcase: View {
	var smoothie: Smoothie = Smoothie(id: "papas-papaya", title: String(localized: "Papa's Papaya", comment: "Smoothie name")) {
		AttributedString(localized: "Papa would be proud of you if he saw you drinking this!", comment: "Papa's Papaya smoothie description")

		Ingredient.orange.measured(with: .cups)
	}
	@Namespace var namespace
	@State private var topmostIngredientID: Ingredient.ID?
	@State private var selectedIngredientID: Ingredient.ID?
	var disableGeometryEffect = false
	var slowAnim = false
	func disableGeometry() -> Self {
		var copy = self
		copy.disableGeometryEffect = true
		return copy
	}
	func slowAnimation() -> Self {
		var copy = self
		copy.slowAnim = true
		return copy
	}

	var content: some View {
		VStack(spacing: 0) {
			VStack(alignment: .leading) {
//				LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16, alignment: .leading)], alignment: .center, spacing: 16) {
					ForEach(smoothie.menuIngredients) { measuredIngredient in
						let ingredient = measuredIngredient.ingredient
						let presenting = selectedIngredientID == measuredIngredient.id
						Button(action: { select(ingredient: ingredient) }) {
							IngredientGraphic(ingredient: measuredIngredient.ingredient, style: presenting ? .cardFront : .thumbnail)
								.matchedGeometryEffect( // убрать для демки
									id: disableGeometryEffect ? "nil" : measuredIngredient.id,
									in: namespace,
									isSource: !presenting
								)
								.contentShape(Rectangle())
						}
						.buttonStyle(.squishable(fadeOnPress: false))
						.aspectRatio(1, contentMode: .fit)
						.zIndex(topmostIngredientID == measuredIngredient.id ? 1 : 0)
						.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
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
					.offset(x: 560) // не нужен будет когда поместим код
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
		if slowAnim {
			withAnimation(.openCard.speed(0.1)) {
				selectedIngredientID = ingredient.id
			}
			return
		}
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

