//
//  FrutiaModel2.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import Foundation

@resultBuilder
enum SmoothieArrayBuilder {
	static func buildEither(first component: [Smoothie]) -> [Smoothie] {
		return component
	}

	static func buildEither(second component: [Smoothie]) -> [Smoothie] {
		return component
	}

	static func buildOptional(_ component: [Smoothie]?) -> [Smoothie] {
		return component ?? []
	}

	static func buildExpression(_ expression: Smoothie) -> [Smoothie] {
		return [expression]
	}

	static func buildExpression(_ expression: ()) -> [Smoothie] {
		return []
	}

	static func buildBlock(_ smoothies: [Smoothie]...) -> [Smoothie] {
		return smoothies.flatMap { $0 }
	}
}

@resultBuilder
enum SmoothieBuilder {
	static func buildBlock(_ description: AttributedString, _ ingredients: MeasuredIngredient...) -> (AttributedString, [MeasuredIngredient]) {
		return (description, ingredients)
	}

	@available(*, unavailable, message: "first statement of SmoothieBuilder must be its description String")
	static func buildBlock(_ ingredients: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
		fatalError()
	}
}

