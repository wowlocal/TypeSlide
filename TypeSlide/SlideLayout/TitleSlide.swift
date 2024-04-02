//
//  ContentView.swift
//  TypeSlide
//
//  Created by Misha Nya on 30.03.2024.
//

import SwiftUI

struct TitleSlide: View {
	var title: String

	var body: some View {
		VStack {
			Spacer()
			Text(title)
				.scalableFont(.statement)
				.scalablePadding()
				.foregroundColor(.black)
				.multilineTextAlignment(.center)
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.white.edgesIgnoringSafeArea(.all))
	}
}

struct SlideViewPreviews: PreviewProvider {
	static var previews: some View {
		Group {
			TitleSlide(title: "Welcome to SwiftUIKeynoteClone")
				.previewDisplayName("Title Slide")

			TitleAndBulletsSlide(title: "Key Points", bullets: ["Point One", "Point Two", "Point Three"])
				.previewDisplayName("Title and Bullets Slide")

			StatementSlide(statement: "SwiftUI makes UI development incredibly efficient.")
				.previewDisplayName("Statement Slide")
		}
		.frame(width: 800, height: 600)
		.background(Color.gray)
	}
}
