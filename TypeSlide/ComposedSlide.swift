//
//  ComposedSlide.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import SwiftUI

struct GenericComposedSlide<Content: View>: View {
	@Binding var substep: Int
	var views: [Content]

	var numberOfSubsteps: Int {
		views.count - 1
	}

	var body: some View {
		views[substep]
			.animation(.default, value: substep)
	}
}
