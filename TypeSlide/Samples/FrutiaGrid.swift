//
//  FrutiaGrid.swift
//  TypeSlide
//
//  Created by Misha Nya on 17.04.2024.
//

import SwiftUI

struct FruitsGrid: View {
	@State var ingrids: [Ingredient] = [
		ingrid(name: "foo", img: .init("orange")),
		ingrid(name: "bar", img: .init("kiwi")),
		ingrid(name: "tar", img: .init("strawberry")),
		ingrid(name: "baz", img: .init("watermelon"))
	]

	static func ingrid(name: String, img: String) -> Ingredient {
		var orange = Ingredient.orange
		orange.name = name
		orange.id = img
		return orange
	}

	var body: some View {
		HStack {
			Spacer()
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16, alignment: .leading)], alignment: .center, spacing: 16) {
				ForEach(ingrids, id: \.name) {
					let ingredient = $0
					let presenting = false
					Button(action: {  }) {
						IngredientGraphic(ingredient: ingredient, style: presenting ? .cardFront : .thumbnail)
							.contentShape(Rectangle())
					}
					.buttonStyle(.squishable(fadeOnPress: false))
					.aspectRatio(1, contentMode: .fit)
					.keyboardShortcut(KeyEquivalent("a"), modifiers: [.control])
				}
			}
			IngredientGraphic(ingredient: Self.ingrid(name: "foo", img: "orange"), style: .cardFront)
				.frame(width: 500)
			Spacer()
		}
	}
}
