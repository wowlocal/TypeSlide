//
//  TypeSlideApp.swift
//  TypeSlide
//
//  Created by Misha Nya on 30.03.2024.
//

import SwiftUI

struct ScaleFactorKey: EnvironmentKey {
	static let defaultValue: CGFloat = 1.0 // Default scale factor
}

extension EnvironmentValues {
	var scaleFactor: CGFloat {
		get { self[ScaleFactorKey.self] }
		set { self[ScaleFactorKey.self] = newValue }
	}
}

struct PrewviewView: View {
	var body: some View {
		TabView {
			SlideView {
				TitleAndBulletsSlide(title: "Key Points", bullets: ["Point One", "Point Two", "Point Three"])
					.previewDisplayName("Title and Bullets Slide")
			}
			SlideView {
				TitleSlide(title: "Presentation Title")
					.previewDisplayName("Title Slide")
			}
			SlideView {
				StatementSlide(statement: "SwiftUI makes UI development incredibly efficient.")
					.previewDisplayName("Statement Slide")
			}
			SlideView {
				SlideViewExample(title: "Welcome to SwiftUIKeynoteClone", content: "This is a simple slide.")
			}
		}
		//.frame(width: 800, height: 600)
		.background(Color.gray)
	}
}

//let defaultSlide = SlideViewExample(title: "Welcome to SwiftUIKeynoteClone", content: "This is a simple slide.")
let defaultSlide = PrewviewView()

import AppKit

@main
struct TypeSlideApp: App {
    var body: some Scene {
		WindowGroup {
			defaultSlide
        }
		.windowStyle(HiddenTitleBarWindowStyle())
		.windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
    }
}
