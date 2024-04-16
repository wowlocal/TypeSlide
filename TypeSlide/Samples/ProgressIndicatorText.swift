//
//  ProgressIndicatorText.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import SwiftUI

struct ProgressIndicatorText: View {
	@State private var progress: Int = 0

	var body: some View {
		HStack {
			Text("Installing: ")
			Progress(progress: progress)
		}
		.padding(.leading, 40)
		.font(.system(size: 200))
		.fontWeight(.bold)
		.foregroundColor(.white)
		.frame(maxWidth: .infinity, alignment: .leading)
		.onAppear {
			withAnimation(Animation.easeInOut(duration: 3)) {
				self.progress = 90
			} completion: {
				withAnimation(.easeInOut(duration: 2)) {
					self.progress = 100
				} completion: {
					withAnimation(.spring.speed(0.2).delay(1)) { self.progress = 146 }
				}
			}
		}
	}

	struct Progress: View, Animatable {
		var progress: Int
		var animatableData: Double {
			get { Double(progress) / 100 }
			set { progress = Int(newValue * 100) }
		}

		var body: some View {
			Text("\(progress) %")
		}
	}
}

