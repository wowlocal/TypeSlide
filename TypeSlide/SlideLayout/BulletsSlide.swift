//
//  BulletsSlide.swift
//  TypeSlide
//
//  Created by Misha Nya on 02.04.2024.
//

import SwiftUI

struct TitleAndBullets: View, Slidable {
	@Binding var substep: Int
	
	var animation: Namespace.ID

	let title: String
	var bullets: [String]

	@State var appeared = false

	var showAsSubsteps: Bool = true

	var numberOfSubsteps: Int {
		guard showAsSubsteps else { return 0 }
		return bullets.count
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 30) {
			Text(title)
				.fontStyle(.title)
				.foregroundColor(.black)
				.fontWeight(.bold)
				.contentTransition(.opacity)
				.matchedGeometryEffect(id: "Title", in: animation, properties: .frame, isSource: true)
				.minimumScaleFactor(0.1)

			if appeared {
				ForEach(bullets[0..<substep], id: \.self) { bullet in
					HStack(alignment: .top) {
						Text("•")
							.fontStyle(.subtitle)
							.colorInvert()
						Text(bullet)
							.fontStyle(.subtitle)
							.colorInvert()
					}.transition(.slide)
				}
				Spacer()
			}
		}
		.onAppear {
			appeared = true
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
