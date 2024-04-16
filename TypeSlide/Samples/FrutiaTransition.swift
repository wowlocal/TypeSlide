//
//  FrutiaTransition.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import SwiftUI

struct AnimatableFontModifier: AnimatableModifier {
	var size: Double
	var weight: Font.Weight = .regular
	var design: Font.Design = .default

	var animatableData: Double {
		get { size }
		set { size = newValue }
	}

	func body(content: Content) -> some View {
		content
			.font(.system(size: size, weight: weight, design: design))
	}
}

extension Ingredient {

	/// Defines how the `Ingredient`'s title should be displayed in card mode
	struct CardTitle {
		var color = Color.black
		var rotation = Angle.degrees(0)
		var offset = CGSize.zero
		var blendMode = BlendMode.normal
		var opacity: Double = 1
		var fontSize: Double = 1
	}

	/// Defines a state for the `Ingredient` to transition from when changing between card and thumbnail
	struct Crop {
		var xOffset: Double = 0
		var yOffset: Double = 0
		var scale: Double = 1

		var offset: CGSize {
			CGSize(width: xOffset, height: yOffset)
		}
	}

	/// The `Ingredient`'s image, useful for backgrounds or thumbnails
	var image: Image {
		Image("ingredient/\(id)", label: Text(name))
			.renderingMode(.original)
	}
}

struct Ingredient: Identifiable, Codable {
	var id: String
	var name: String
	var title = CardTitle()
	var thumbnailCrop = Crop()
	var cardCrop = Crop()

	enum CodingKeys: String, CodingKey {
		case id
		case name
	}
}

enum FlipViewSide {
	case front
	case back

	mutating func toggle() {
		self = self == .front ? .back : .front
	}
}

public protocol DisplayableMeasurement {
	var unitImage: Image { get }
	func localizedSummary(unitStyle: MeasurementFormatter.UnitStyle, unitOptions: MeasurementFormatter.UnitOptions) -> String
}

extension DisplayableMeasurement {
	public func localizedSummary() -> String {
		localizedSummary(unitStyle: .long, unitOptions: [.providedUnit])
	}
}

extension Measurement: DisplayableMeasurement {
	public func localizedSummary(unitStyle: MeasurementFormatter.UnitStyle = .long,
								 unitOptions: MeasurementFormatter.UnitOptions = [.providedUnit]) -> String {
		let formatter = MeasurementFormatter()
		formatter.unitStyle = unitStyle
		formatter.unitOptions = unitOptions
		return formatter.string(from: self)
	}

	public var unitImage: Image {
		unit.unitIcon
	}
}


public struct Nutrition: Identifiable {
	public var id: String
	public var name: LocalizedStringKey
	public var measurement: DisplayableMeasurement
	public var indented: Bool = false
}

extension NutritionFact {
	public var nutritions: [Nutrition] {
		[
			Nutrition(
				id: "totalFat",
				name: "Total Fat",
				measurement: totalFat
			),
			Nutrition(
				id: "totalSaturatedFat",
				name: "Saturated Fat",
				measurement: totalSaturatedFat,
				indented: true
			),
			Nutrition(
				id: "totalMonounsaturatedFat",
				name: "Monounsaturated Fat",
				measurement: totalMonounsaturatedFat,
				indented: true
			),
			Nutrition(
				id: "totalPolyunsaturatedFat",
				name: "Polyunsaturated Fat",
				measurement: totalPolyunsaturatedFat,
				indented: true
			),
			Nutrition(
				id: "cholesterol",
				name: "Cholesterol",
				measurement: cholesterol
			),
			Nutrition(
				id: "sodium",
				name: "Sodium",
				measurement: sodium
			),
			Nutrition(
				id: "totalCarbohydrates",
				name: "Total Carbohydrates",
				measurement: totalCarbohydrates
			),
			Nutrition(
				id: "dietaryFiber",
				name: "Dietary Fiber",
				measurement: dietaryFiber,
				indented: true
			),
			Nutrition(
				id: "sugar",
				name: "Sugar",
				measurement: sugar,
				indented: true
			),
			Nutrition(
				id: "protein",
				name: "Protein",
				measurement: protein
			),
			Nutrition(
				id: "calcium",
				name: "Calcium",
				measurement: calcium
			),
			Nutrition(
				id: "potassium",
				name: "Potassium",
				measurement: potassium
			),
			Nutrition(
				id: "vitaminA",
				name: "Vitamin A",
				measurement: vitaminA
			),
			Nutrition(
				id: "vitaminC",
				name: "Vitamin C",
				measurement: vitaminC
			),
			Nutrition(
				id: "iron",
				name: "Iron",
				measurement: iron
			)
		]
	}
}


public struct NutritionRow: View {
	public var nutrition: Nutrition

	public init(nutrition: Nutrition) {
		self.nutrition = nutrition
	}

	var nutritionValue: String {
		nutrition.measurement.localizedSummary(
			unitStyle: .short,
			unitOptions: .providedUnit
		)
	}

	public var body: some View {
		HStack {
			Text(nutrition.name)
				.fontWeight(.medium)
			Spacer()
			Text(nutritionValue)
				.fontWeight(.semibold)
				.foregroundStyle(.secondary)
		}
		.font(.footnote)
	}
}

public struct NutritionFactView: View {

	public var nutritionFact: NutritionFact

	public init(nutritionFact: NutritionFact) {
		self.nutritionFact = nutritionFact.converted(toVolume: .cups(1))
	}

	public var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			VStack(alignment: .leading) {
				Text("Nutrition Facts")
					.font(.title2)
					.bold()
				Text("Serving Size 1 Cup")
					.font(.footnote)
				Text(nutritionFact.energy.formatted(.measurement(width: .wide, usage: .food)))
					.fontWeight(.semibold)
					.padding(.top, 10)
			}
			.padding(20)

			Divider()
				.padding(.horizontal, 20)

			ScrollView {
				VStack(spacing: 0) {
					ForEach(nutritionFact.nutritions) { nutrition in
						NutritionRow(nutrition: nutrition)
							.padding(.vertical, 4)
							.padding(.leading, nutrition.indented ? 10 : 0)
						Divider()
					}
				}
				.padding([.bottom, .horizontal], 20)
			}
		}
	}
}

extension View {
	func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
		self.modifier(AnimatableFontModifier(size: size, weight: weight, design: design))
	}
}

struct IngredientGraphic: View {
	var ingredient: Ingredient
	var style: Style
	var closeAction: () -> Void = {}
	var flipAction: () -> Void = {}

	enum Style {
		case cardFront
		case cardBack
		case thumbnail
	}

	var displayingAsCard: Bool {
		style == .cardFront || style == .cardBack
	}

	var shape = RoundedRectangle(cornerRadius: 16, style: .continuous)

	var body: some View {
		ZStack {
			image
			if style != .cardBack {
				title
			}

			if style == .cardFront {
				cardControls(for: .front)
					.foregroundStyle(ingredient.title.color)
					.opacity(ingredient.title.opacity)
					.blendMode(ingredient.title.blendMode)
			}

			if style == .cardBack {
				ZStack {
					if let nutritionFact = ingredient.nutritionFact {
						NutritionFactView(nutritionFact: nutritionFact)
							.padding(.bottom, 70)
					}
					cardControls(for: .back)
				}
				.background(.thinMaterial)
			}
		}
		.frame(minWidth: 130, maxWidth: 400, maxHeight: 500)
		.compositingGroup()
		.clipShape(shape)
		.overlay {
			shape
				.inset(by: 0.5)
				.stroke(.quaternary, lineWidth: 0.5)
		}
		.contentShape(shape)
		.accessibilityElement(children: .contain)
	}

	var image: some View {
		GeometryReader { geo in
			ingredient.image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: geo.size.width, height: geo.size.height)
				.scaleEffect(displayingAsCard ? ingredient.cardCrop.scale : ingredient.thumbnailCrop.scale)
				.offset(displayingAsCard ? ingredient.cardCrop.offset : ingredient.thumbnailCrop.offset)
				.frame(width: geo.size.width, height: geo.size.height)
				.scaleEffect(x: style == .cardBack ? -1 : 1)
		}
		.accessibility(hidden: true)
	}

	var title: some View {
		Text(ingredient.name.uppercased())
			.padding(.horizontal, 8)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.lineLimit(2)
			.multilineTextAlignment(.center)
			.foregroundStyle(ingredient.title.color)
			.rotationEffect(displayingAsCard ? ingredient.title.rotation: .degrees(0))
			.opacity(ingredient.title.opacity)
			.blendMode(ingredient.title.blendMode)
			.animatableFont(size: displayingAsCard ? ingredient.title.fontSize : 40, weight: .bold)
			.minimumScaleFactor(0.25)
			.offset(displayingAsCard ? ingredient.title.offset : .zero)
	}

	func cardControls(for side: FlipViewSide) -> some View {
		VStack {
			if side == .front {
				CardActionButton(label: "Close", systemImage: "xmark.circle.fill", action: closeAction)
					.scaleEffect(displayingAsCard ? 1 : 0.5)
					.opacity(displayingAsCard ? 1 : 0)
			}
			Spacer()
			CardActionButton(
				label: side == .front ? "Open Nutrition Facts" : "Close Nutrition Facts",
				systemImage: side == .front ? "info.circle.fill" : "arrow.left.circle.fill",
				action: flipAction
			)
			.scaleEffect(displayingAsCard ? 1 : 0.5)
			.opacity(displayingAsCard ? 1 : 0)
		}
		.frame(maxWidth: .infinity, alignment: .trailing)
	}
}

struct CardActionButton: View {
	var label: LocalizedStringKey
	var systemImage: String
	var action: () -> Void

	var body: some View {
		Button(action: action) {
			Image(systemName: systemImage)
				.font(Font.title.bold())
				.imageScale(.large)
				.frame(width: 44, height: 44)
				.padding()
				.contentShape(Rectangle())
		}
		.buttonStyle(SquishableButtonStyle(fadeOnPress: false))
		.accessibility(label: Text(label))
	}
}

struct SquishableButtonStyle: ButtonStyle {
	var fadeOnPress = true

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
			.animation(.spring(response: 0.2, dampingFraction: 0.5), value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == SquishableButtonStyle {
	static var squishable: SquishableButtonStyle {
		SquishableButtonStyle()
	}

	static func squishable(fadeOnPress: Bool = true) -> SquishableButtonStyle {
		SquishableButtonStyle(fadeOnPress: fadeOnPress)
	}
}

struct FlipView<Front: View, Back: View>: View {
	var visibleSide: FlipViewSide
	@ViewBuilder var front: Front
	@ViewBuilder var back: Back

	var body: some View {
		ZStack {
			front
				.modifier(FlipModifier(side: .front, visibleSide: visibleSide))
			back
				.modifier(FlipModifier(side: .back, visibleSide: visibleSide))
		}
	}
}

struct FlipModifier: AnimatableModifier {
	var side: FlipViewSide
	var flipProgress: Double

	init(side: FlipViewSide, visibleSide: FlipViewSide) {
		self.side = side
		self.flipProgress = visibleSide == .front ? 0 : 1
	}

	public var animatableData: Double {
		get { flipProgress }
		set { flipProgress = newValue }
	}

	var visible: Bool {
		switch side {
		case .front:
			return flipProgress <= 0.5
		case .back:
			return flipProgress > 0.5
		}
	}

	public func body(content: Content) -> some View {
		ZStack {
			content
				.opacity(visible ? 1 : 0)
				.accessibility(hidden: !visible)
		}
		.scaleEffect(x: scale, y: 1.0)
		.rotation3DEffect(.degrees(flipProgress * -180), axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 0.5)
	}

	var scale: CGFloat {
		switch side {
		case .front:
			return 1.0
		case .back:
			return -1.0
		}
	}
}

extension Ingredient {
	static let orange = Ingredient(
		id: "orange",
		name: String(localized: "Sexy", table: "Ingredients", comment: "Ingredient name"),
		title: CardTitle(
			rotation: Angle.degrees(-90),
			offset: CGSize(width: -130, height: -60),
			blendMode: .overlay,
			fontSize: 80
		),
		thumbnailCrop: Crop(yOffset: -15, scale: 2)
	)
}

struct IngredientCard: View {
	var ingredient: Ingredient
	var presenting: Bool
	var closeAction: () -> Void = {}

	@State private var visibleSide = FlipViewSide.front

	var body: some View {
		FlipView(visibleSide: visibleSide) {
			IngredientGraphic(ingredient: ingredient, style: presenting ? .cardFront : .thumbnail, closeAction: closeAction, flipAction: flipCard)
		} back: {
			IngredientGraphic(ingredient: ingredient, style: .cardBack, closeAction: closeAction, flipAction: flipCard)
		}
		.contentShape(Rectangle())
		.animation(.flipCard, value: visibleSide)
	}

	func flipCard() {
		visibleSide.toggle()
	}
}

extension Animation {
	static let openCard = Animation.spring(response: 0.45, dampingFraction: 0.9)
	static let closeCard = Animation.spring(response: 0.35, dampingFraction: 1)
	static let flipCard = Animation.spring(response: 0.35, dampingFraction: 0.7)
}
