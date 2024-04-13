//
//  Color.swift
//  TypeSlide
//
//  Created by Misha Nya on 13.04.2024.
//

import Foundation
import SwiftUI
import Accelerate

func createColorGradient(sampleSize: Int) -> [[Int]] {
	// Define the start and end colors
	let startColor: [Double] = [74, 165, 248] // Light blue
	let endColor: [Double] = [244, 175, 62]    // Red

	// Create linear spaces for each component
	func linspace(start: Double, end: Double, num: Int) -> [Double] {
		var result = [Double](repeating: 0.0, count: num)
		vDSP_vgenD([start], [end], &result, 1, vDSP_Length(num))
		return result
	}

	let reds = linspace(start: startColor[0], end: endColor[0], num: sampleSize).map { Int($0) }
	let greens = linspace(start: startColor[1], end: endColor[1], num: sampleSize).map { Int($0) }
	let blues = linspace(start: startColor[2], end: endColor[2], num: sampleSize).map { Int($0) }

	// Stack the RGB components into a single array
	var gradient: [[Int]] = []
	for i in 0..<sampleSize {
		gradient.append([reds[i], greens[i], blues[i]])
	}
	return gradient
}


func generateColorSequence(n: Int, colorSpace: Color.RGBColorSpace = .sRGB) -> [Color] {
	let startHue: Double = 0.58, endHue: Double = 0.02
	let startSaturation: Double = 0.7, endSaturation: Double = 0.76
	let startBrightness: Double = 0.97, endBrightness: Double = 0.24

	// Generate linearly interpolated HSV values
	let hues = Array(stride(from: startHue, to: endHue, by: (endHue - startHue) / Double(n-1)))
	let saturations = Array(stride(from: startSaturation, to: endSaturation, by: (endSaturation - startSaturation) / Double(n-1)))
	let brightnesses = Array(stride(from: startBrightness, to: endBrightness, by: (endBrightness - startBrightness) / Double(n-1)))

	// Convert to RGB and then to SwiftUI Colors
	let colors = zip(hues, zip(saturations, brightnesses)).map { (hue, satBright) -> Color in
		let (saturation, brightness) = satBright
		let rgb = hsvToRGB(hue: hue, saturation: saturation, value: brightness)
		return Color(colorSpace, red: rgb.red, green: rgb.green, blue: rgb.blue, opacity: 1)
	}

	return colors
}

func hsvToRGB(hue: Double, saturation: Double, value: Double) -> (red: Double, green: Double, blue: Double) {
	let i = Int(hue * 6)
	let f = hue * 6 - Double(i)
	let p = value * (1 - saturation)
	let q = value * (1 - f * saturation)
	let t = value * (1 - (1 - f) * saturation)

	let (r, g, b): (Double, Double, Double)
	switch i % 6 {
	case 0: r = value; g = t; b = p
	case 1: r = q; g = value; b = p
	case 2: r = p; g = value; b = t
	case 3: r = p; g = q; b = value
	case 4: r = t; g = p; b = value
	case 5: r = value; g = p; b = q
	default: r = value; g = value; b = value // should never happen
	}
	return (r, g, b)
}




func generateRgbColorsFunky(n: Int) -> [(Int, Int, Int)] {
	var colors: [(Int, Int, Int)] = []
	for i in 0..<n {
		var r: Int
		var g: Int
		var b: Int

		if i < n / 4 {
			// First quarter: slow increase in red, rapid decrease in green, blue almost constant
			r = Int(74 + Double(i) * Double(96 - 74) / Double(n / 4))
			g = Int(165 - Double(i) * Double(165 - 17) / Double(n / 4))
			b = Int(248 - Double(i) * Double(248 - 245) / Double(n / 4))
		} else if i < n / 2 {
			// Second quarter: continue the trends but adjust rates if necessary
			r = Int(96 + Double(i - n / 4) * Double(120 - 96) / Double(n / 4))
			g = Int(17 - Double(i - n / 4) * Double(17 - 14) / Double(n / 4))
			b = Int(245 - Double(i - n / 4) * Double(245 - 242) / Double(n / 4))
		} else if i < 3 * n / 4 {
			// Third quarter: Red stabilizes or increases slightly, green and blue decrease
			r = Int(120 + Double(i - n / 2) * Double(180 - 120) / Double(n / 4))
			g = Int(14 - Double(i - n / 2) * Double(14 - 10) / Double(n / 4))
			b = Int(242 - Double(i - n / 2) * Double(242 - 180) / Double(n / 4))
		} else {
			// Last quarter: Final adjustments to reach the end values
			r = Int(180 + Double(i - 3 * n / 4) * Double(237 - 180) / Double(n / 4))
			g = Int(10 - Double(i - 3 * n / 4) * Double(10 - 0) / Double(n / 4))
			b = Int(180 - Double(i - 3 * n / 4) * Double(180 - 53) / Double(n / 4))
		}

		// Ensure RGB values remain within the valid range [0, 255]
		r = max(0, min(255, r))
		g = max(0, min(255, g))
		b = max(0, min(255, b))

		colors.append((r, g, b))
	}
	return colors
}


func generateRgbColorsFunkyOrange(n: Int) -> [(Int, Int, Int)] {
	var colors: [(Int, Int, Int)] = []
	for i in 0..<n {
		var r: Int
		var g: Int
		var b: Int

		if i < n / 4 {
			// First quarter: slow increase in red, rapid decrease in green, blue almost constant
			r = Int(74 + Double(i) * Double(96 - 74) / Double(n / 4))
			g = Int(165 - Double(i) * Double(165 - 17) / Double(n / 4))
			b = Int(248 - Double(i) * Double(248 - 245) / Double(n / 4))
		} else if i < n / 2 {
			// Second quarter: continue the trends but adjust rates if necessary
			r = Int(96 + Double(i - n / 4) * Double(120 - 96) / Double(n / 4))
			g = Int(17 - Double(i - n / 4) * Double(17 - 14) / Double(n / 4))
			b = Int(245 - Double(i - n / 4) * Double(245 - 242) / Double(n / 4))
		} else if i < 3 * n / 4 {
			// Third quarter: Red stabilizes or increases slightly, green and blue decrease
			r = Int(120 + Double(i - n / 2) * Double(180 - 120) / Double(n / 4))
			g = Int(14 - Double(i - n / 2) * Double(14 - 10) / Double(n / 4))
			b = Int(242 - Double(i - n / 2) * Double(242 - 180) / Double(n / 4))
		} else {
			// Last quarter: Adjust to orange tone
			r = Int(237 + Double(i - 3 * n / 4) * Double(255 - 237) / Double(n / 4))
			g = Int(125 + Double(i - 3 * n / 4) * Double(165 - 125) / Double(n / 4))
			b = Int(53 - Double(i - 3 * n / 4) * Double(53 - 20) / Double(n / 4))
		}

		// Ensure RGB values remain within the valid range [0, 255]
		r = max(0, min(255, r))
		g = max(0, min(255, g))
		b = max(0, min(255, b))

		colors.append((r, g, b))
	}
	return colors
}

func generateRgbColorsFunkyOrangePink(n: Int) -> [(Int, Int, Int)] {
	let anchorPoints: [(Int, Int, Int)] = [
		(74, 165, 248),   // Anchor 1
		(48, 59, 245),    // Anchor 2
		(81, 14, 245),    // Anchor 3
		(120, 23, 245),   // Anchor 4
		(173, 36, 246),   // Anchor 5
		(211, 45, 215),   // Anchor 6
		(235, 53, 158),   // Anchor 7
		(236, 75, 88),    // Anchor 8
		(237, 101, 52),   // Anchor 9
		(240, 137, 52)    // Anchor 10
	]

	var colors: [(Int, Int, Int)] = []
	let segments = anchorPoints.count - 1
	print("[Color]: Segments: \(segments)")

	for i in 0..<n {
		let segmentSize = max(n / segments, 1)
		print("[Color]: Segment Size: \(segmentSize)")
		let currentSegment = i / segmentSize
		print("[Color]: Current Segment: \(currentSegment)")
		let progressInSegment = i % segmentSize
		print("[Color]: Progress in Segment: \(progressInSegment)")
		let progressFraction = Double(progressInSegment) / Double(segmentSize)
		print("[Color]: Progress Fraction: \(progressFraction)")

		if currentSegment < segments {
			let (r1, g1, b1) = anchorPoints[currentSegment]
			let (r2, g2, b2) = anchorPoints[currentSegment + 1]

			let r = Int(Double(r1) + (Double(r2) - Double(r1)) * progressFraction)
			let g = Int(Double(g1) + (Double(g2) - Double(g1)) * progressFraction)
			let b = Int(Double(b1) + (Double(b2) - Double(b1)) * progressFraction)

			colors.append((r, g, b))
			print("[Color]: Color appended: (\(r), \(g), \(b))")
		} else {
			colors.append(anchorPoints.last!)
			print("[Color]: Last anchor point appended")
		}
	}

	return colors
}
