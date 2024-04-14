//
//  Entry.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation
import AppKit
import SwiftUI

@main
struct TypeSlideApp: App {

	var body: some Scene {
		WindowGroup {
			Presentation()
				//.padding([.top, .bottom], 30)
				.ignoresSafeArea(.all)
				.frame(minWidth: 500, maxWidth: .infinity, minHeight: 500 / (16 / 9), maxHeight: .infinity)
				.background(TransparentWindow().ignoresSafeArea(.all))
				.onAppear {
					for window in NSApplication.shared.windows {
						window.standardWindowButton(.closeButton)?.isHidden = true
						window.standardWindowButton(.miniaturizeButton)?.isHidden = true
						window.standardWindowButton(.zoomButton)?.isHidden = true
						window.aspectRatio = CGSize(width: 16, height: 9)
					}
				}
		}
		.windowStyle(HiddenTitleBarWindowStyle())
		.windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
		.windowResizability(.contentSize)
	}
}

struct TransparentWindow: NSViewRepresentable
{
	func updateNSView(_ nsView: NSView, context: Context) {}

	func makeNSView(context: Self.Context) -> NSView {
		let view = NSVisualEffectView()
		view.material = .hudWindow
		view.blendingMode = .behindWindow
		return view
	}
}
