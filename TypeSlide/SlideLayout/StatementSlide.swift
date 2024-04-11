//
//  StatementSlide.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

struct StatementSlide: View {
	var statement: String

	var body: some View {
		VStack {
			Spacer()
			Text(statement)
				.fontStyle(.title)
				.colorInvert()
				.fontWeight(.semibold)
				.multilineTextAlignment(.center)
				.padding()
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
