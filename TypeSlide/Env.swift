//
//  Env.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import SwiftUI

struct SamplesEnvironmentKey: EnvironmentKey {
	static let defaultValue: Samples = .init()
}

extension EnvironmentValues {
	var codeSamples: Samples {
		get { self[SamplesEnvironmentKey.self] }
		set { self[SamplesEnvironmentKey.self] = newValue }
	}
}

struct DebugEnvironmentKey: EnvironmentKey {
	static let defaultValue: Bool = false // Default value for the debug variable
}

extension EnvironmentValues {
	var debug: Bool {
		get { self[DebugEnvironmentKey.self] }
		set { self[DebugEnvironmentKey.self] = newValue }
	}
}
