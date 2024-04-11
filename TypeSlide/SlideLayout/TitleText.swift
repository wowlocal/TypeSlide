//
//  ContentView.swift
//  TypeSlide
//
//  Created by Misha Nya on 30.03.2024.
//

import SwiftUI

struct TitleText: View {
	var title: String

	var animation: Namespace.ID

	var body: some View {
		VStack {
			Spacer()
			Text(title)
				.fontStyle(.statement)
				.padding()
				//.scaleEffect(scale) TODO: rework all vues to use scale effect
				.foregroundColor(.orange)
				.contentTransition(.opacity)
				.multilineTextAlignment(.center)
				.minimumScaleFactor(0.1)
				.matchedGeometryEffect(id: "Title", in: animation, properties: .frame, isSource: true)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct SlideViewPreviews: PreviewProvider {
	static var previews: some View {
		Group {
//			TitleSlide(title: "Welcome to SwiftUIKeynoteClone")
//				.previewDisplayName("Title Slide")

//			TitleAndBulletsSlide(title: "Key Points", bullets: ["Point One", "Point Two", "Point Three"])
//				.previewDisplayName("Title and Bullets Slide")

			StatementSlide(statement: "SwiftUI makes UI development incredibly efficient.")
				.previewDisplayName("Statement Slide")
		}
		.frame(width: 800, height: 600)
		.background(Color.gray)
	}
}
