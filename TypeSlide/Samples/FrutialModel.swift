//
//  FrutialModel.swift
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

import Foundation

public struct Density {
	public var mass: Measurement<UnitMass>
	public var volume: Measurement<UnitVolume>

	public init(_ massAmount: Double, _ massUnit: UnitMass, per volumeAmount: Double, _ volumeUnit: UnitVolume) {
		self.mass = Measurement(value: massAmount, unit: massUnit)
		self.volume = Measurement(value: volumeAmount, unit: volumeUnit)
	}

	public init(mass: Measurement<UnitMass>, volume: Measurement<UnitVolume>) {
		self.mass = mass
		self.volume = volume
	}
}

public struct NutritionFact {
	public var identifier: String
	public var localizedFoodItemName: String

	public var referenceMass: Measurement<UnitMass>

	public var density: Density

	public var totalSaturatedFat: Measurement<UnitMass>
	public var totalMonounsaturatedFat: Measurement<UnitMass>
	public var totalPolyunsaturatedFat: Measurement<UnitMass>
	public var totalFat: Measurement<UnitMass> {
		return totalSaturatedFat + totalMonounsaturatedFat + totalPolyunsaturatedFat
	}

	public var cholesterol: Measurement<UnitMass>
	public var sodium: Measurement<UnitMass>

	public var totalCarbohydrates: Measurement<UnitMass>
	public var dietaryFiber: Measurement<UnitMass>
	public var sugar: Measurement<UnitMass>

	public var protein: Measurement<UnitMass>

	public var calcium: Measurement<UnitMass>
	public var potassium: Measurement<UnitMass>

	public var vitaminA: Measurement<UnitMass>
	public var vitaminC: Measurement<UnitMass>
	public var iron: Measurement<UnitMass>
}

extension NutritionFact {
	public func converted(toVolume newReferenceVolume: Measurement<UnitVolume>) -> NutritionFact {
		let newRefMassInCups = newReferenceVolume.converted(to: .cups).value
		let oldRefMassInCups = referenceMass.convertedToVolume(usingDensity: self.density).value

		let scaleFactor = newRefMassInCups / oldRefMassInCups

		return NutritionFact(
			identifier: identifier,
			localizedFoodItemName: localizedFoodItemName,
			referenceMass: referenceMass * scaleFactor,
			density: density,
			totalSaturatedFat: totalSaturatedFat * scaleFactor,
			totalMonounsaturatedFat: totalMonounsaturatedFat * scaleFactor,
			totalPolyunsaturatedFat: totalPolyunsaturatedFat * scaleFactor,
			cholesterol: cholesterol * scaleFactor,
			sodium: sodium * scaleFactor,
			totalCarbohydrates: totalCarbohydrates * scaleFactor,
			dietaryFiber: dietaryFiber * scaleFactor,
			sugar: sugar * scaleFactor,
			protein: protein * scaleFactor,
			calcium: calcium * scaleFactor,
			potassium: potassium * scaleFactor,
			vitaminA: vitaminA * scaleFactor,
			vitaminC: vitaminC * scaleFactor,
			iron: iron * scaleFactor
		)
	}

	public func converted(toMass newReferenceMass: Measurement<UnitMass>) -> NutritionFact {
		let newRefMassInGrams = newReferenceMass.converted(to: .grams).value
		let oldRefMassInGrams = referenceMass.converted(to: .grams).value
		let scaleFactor = newRefMassInGrams / oldRefMassInGrams
		return NutritionFact(
			identifier: identifier,
			localizedFoodItemName: localizedFoodItemName,
			referenceMass: newReferenceMass,
			density: density,
			totalSaturatedFat: totalSaturatedFat * scaleFactor,
			totalMonounsaturatedFat: totalMonounsaturatedFat * scaleFactor,
			totalPolyunsaturatedFat: totalPolyunsaturatedFat * scaleFactor,
			cholesterol: cholesterol * scaleFactor,
			sodium: sodium * scaleFactor,
			totalCarbohydrates: totalCarbohydrates * scaleFactor,
			dietaryFiber: dietaryFiber * scaleFactor,
			sugar: sugar * scaleFactor,
			protein: protein * scaleFactor,
			calcium: calcium * scaleFactor,
			potassium: potassium * scaleFactor,
			vitaminA: vitaminA * scaleFactor,
			vitaminC: vitaminC * scaleFactor,
			iron: iron * scaleFactor
		)
	}

	public func amount(_ mass: Measurement<UnitMass>) -> NutritionFact {
		return converted(toMass: mass)
	}

	public func amount(_ volume: Measurement<UnitVolume>) -> NutritionFact {
		let mass = volume.convertedToMass(usingDensity: density)
		return converted(toMass: mass)
	}
}

extension NutritionFact {
	/// Nutritional information is for 100 grams, unless a `mass` is specified.
	public static func lookupFoodItem(_ foodItemIdentifier: String,
									  forMass mass: Measurement<UnitMass> = Measurement(value: 100, unit: .grams)) -> NutritionFact? {
		return nutritionFacts[foodItemIdentifier]?.converted(toMass: mass)
	}

	/// Nutritional information is for 1 cup, unless a `volume` is specified.
	public static func lookupFoodItem(_ foodItemIdentifier: String,
									  forVolume volume: Measurement<UnitVolume> = Measurement(value: 1, unit: .cups)) -> NutritionFact? {
		guard let nutritionFact = nutritionFacts[foodItemIdentifier] else {
			return nil
		}

		// Convert volume to mass via density
		let mass = volume.convertedToMass(usingDensity: nutritionFact.density)
		return nutritionFact.converted(toMass: mass)
	}

	// MARK: - Examples

	public static var banana: NutritionFact {
		nutritionFacts["banana"]!
	}

	public static var blueberry: NutritionFact {
		nutritionFacts["blueberry"]!
	}

	public static var peanutButter: NutritionFact {
		nutritionFacts["peanut-butter"]!
	}

	public static var almondMilk: NutritionFact {
		nutritionFacts["almond-milk"]!
	}

	public static var zero: NutritionFact {
		NutritionFact(
			identifier: "",
			localizedFoodItemName: "",
			referenceMass: .grams(0),
			density: Density(mass: .grams(1), volume: .cups(1)),
			totalSaturatedFat: .grams(0),
			totalMonounsaturatedFat: .grams(0),
			totalPolyunsaturatedFat: .grams(0),
			cholesterol: .grams(0),
			sodium: .grams(0),
			totalCarbohydrates: .grams(0),
			dietaryFiber: .grams(0),
			sugar: .grams(0),
			protein: .grams(0),
			calcium: .grams(0),
			potassium: .grams(0),
			vitaminA: .grams(0),
			vitaminC: .grams(0),
			iron: .grams(0)
		)
	}
}

extension NutritionFact {
	// Support adding up nutritional facts
	public static func + (lhs: NutritionFact, rhs: NutritionFact) -> NutritionFact {
		// Calculate combined mass, volume and density
		let totalMass = lhs.referenceMass + rhs.referenceMass
		let lhsVolume = lhs.referenceMass.convertedToVolume(usingDensity: lhs.density)
		let rhsVolume = lhs.referenceMass.convertedToVolume(usingDensity: lhs.density)
		let totalVolume = lhsVolume + rhsVolume

		return NutritionFact(
			identifier: "",
			localizedFoodItemName: "",
			referenceMass: totalMass,
			density: Density(mass: totalMass, volume: totalVolume),
			totalSaturatedFat: lhs.totalSaturatedFat + rhs.totalSaturatedFat,
			totalMonounsaturatedFat: lhs.totalMonounsaturatedFat + rhs.totalMonounsaturatedFat,
			totalPolyunsaturatedFat: lhs.totalPolyunsaturatedFat + rhs.totalPolyunsaturatedFat,
			cholesterol: lhs.cholesterol + rhs.cholesterol,
			sodium: lhs.sodium + rhs.sodium,
			totalCarbohydrates: lhs.totalCarbohydrates + rhs.totalCarbohydrates,
			dietaryFiber: lhs.dietaryFiber + rhs.dietaryFiber,
			sugar: lhs.sugar + rhs.sugar,
			protein: lhs.protein + rhs.protein,
			calcium: lhs.calcium + rhs.calcium,
			potassium: lhs.potassium + rhs.potassium,
			vitaminA: lhs.vitaminA + rhs.vitaminA,
			vitaminC: lhs.vitaminC + rhs.vitaminC,
			iron: lhs.iron + rhs.iron
		)
	}
}

// MARK: - CustomStringConvertible

extension NutritionFact: CustomStringConvertible {
	public var description: String {
		let suffix = identifier.isEmpty ? "" : " of \(identifier)"
		return "\(referenceMass.converted(to: .grams).localizedSummary(unitStyle: .medium))" + suffix
	}
}

// MARK: - Volume <-> Mass Conversion

extension Measurement where UnitType == UnitVolume {
	public func convertedToMass(usingDensity density: Density) -> Measurement<UnitMass> {
		let densityLiters = density.volume.converted(to: .liters).value
		let liters = converted(to: .liters).value
		let scale = liters / densityLiters
		return density.mass * scale
	}
}

extension Measurement where UnitType == UnitMass {
	public func convertedToVolume(usingDensity density: Density) -> Measurement<UnitVolume> {
		let densityKilograms = density.mass.converted(to: .kilograms).value
		let kilograms = converted(to: .kilograms).value
		let scale = kilograms / densityKilograms
		return density.volume * scale
	}
}

// MARK: - Convenience Accessors

extension Measurement where UnitType == UnitVolume {
	public static func cups(_ cups: Double) -> Measurement<UnitVolume> {
		return Measurement(value: cups, unit: .cups)
	}

	public static func tablespoons(_ tablespoons: Double) -> Measurement<UnitVolume> {
		return Measurement(value: tablespoons, unit: .tablespoons)
	}
}

extension Measurement where UnitType == UnitMass {
	public static func grams(_ grams: Double) -> Measurement<UnitMass> {
		return Measurement(value: grams, unit: .grams)
	}
}

let nutritionFacts: [String: NutritionFact] = {
		if let jsonURL = Bundle.main.url(forResource: "NutritionalItems", withExtension: "json"),
		   let jsonData = try? Data(contentsOf: jsonURL),
		   let facts = try? JSONDecoder().decode(Dictionary<String, NutritionFact>.self, from: jsonData) {
			return facts
		} else {
			return [String: NutritionFact]()
		}
	}()

extension NutritionFact: Decodable {
	enum CodingKeys: String, CodingKey {
		case identifier
		case localizedFoodItemName
		case referenceMass
		case density
		case totalSaturatedFat
		case totalMonounsaturatedFat
		case totalPolyunsaturatedFat
		case cholesterol
		case sodium
		case totalCarbohydrates
		case dietaryFiber
		case sugar
		case protein
		case calcium
		case potassium
		case vitaminA
		case vitaminC
		case iron
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)

		identifier = try values.decode(String.self, forKey: .identifier)
		localizedFoodItemName = try values.decode(String.self, forKey: .localizedFoodItemName)

		let densityString = try values.decode(String.self, forKey: .density)
		density = Density.fromString(densityString)

		referenceMass = try values.decode(Measurement<UnitMass>.self, forKey: .referenceMass)
		totalSaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalSaturatedFat)
		totalMonounsaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalMonounsaturatedFat)
		totalPolyunsaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalPolyunsaturatedFat)
		cholesterol = try values.decode(Measurement<UnitMass>.self, forKey: .cholesterol)
		sodium = try values.decode(Measurement<UnitMass>.self, forKey: .sodium)
		totalCarbohydrates = try values.decode(Measurement<UnitMass>.self, forKey: .totalCarbohydrates)
		dietaryFiber = try values.decode(Measurement<UnitMass>.self, forKey: .dietaryFiber)
		sugar = try values.decode(Measurement<UnitMass>.self, forKey: .sugar)
		protein = try values.decode(Measurement<UnitMass>.self, forKey: .protein)
		calcium = try values.decode(Measurement<UnitMass>.self, forKey: .calcium)
		potassium = try values.decode(Measurement<UnitMass>.self, forKey: .potassium)
		vitaminA = try values.decode(Measurement<UnitMass>.self, forKey: .vitaminA)
		vitaminC = try values.decode(Measurement<UnitMass>.self, forKey: .vitaminC)
		iron = try values.decode(Measurement<UnitMass>.self, forKey: .iron)
	}
}

extension KeyedDecodingContainer {
	public func decode(_ type: Measurement<UnitMass>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Measurement<UnitMass> {
		let valueString = try decode(String.self, forKey: key)
		return Measurement(string: valueString)
	}

	public func decode(_ type: Measurement<UnitVolume>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Measurement<UnitVolume> {
		let valueString = try decode(String.self, forKey: key)
		return Measurement(string: valueString)
	}
}

extension Measurement where UnitType == UnitMass {
	init(string: String) {
		let components = string.split(separator: " ")
		let valueString = String(components[0])
		let unitSymbolString = String(components[1])
		self.init(
			value: Double(valueString)!,
			unit: UnitMass.fromSymbol(unitSymbolString)
		)
	}
}

extension Measurement where UnitType == UnitVolume {
	init(string: String) {
		let components = string.split(separator: " ")
		let valueString = String(components[0])
		let unitSymbolString = String(components[1])
		self.init(
			value: Double(valueString)!,
			unit: UnitVolume.fromSymbol(unitSymbolString)
		)
	}
}

// These methods return Units with an associated converter, whereas units
// initialized from a string using the `Unit(symbol:)` initializer
// do not have a converter associated and thereby don't support conversion.

extension UnitVolume {
	static func fromSymbol(_ symbol: String) -> UnitVolume {
		switch symbol {
		case "gal":
			return .gallons
		case "cup":
			return .cups
		default:
			return UnitVolume(symbol: symbol)
		}
	}
}

extension UnitMass {
	static func fromSymbol(_ symbol: String) -> UnitMass {
		switch symbol {
		case "kg":
			return .kilograms
		case "g":
			return .grams
		case "mg":
			return .milligrams
		default:
			return UnitMass(symbol: symbol)
		}
	}
}

extension UnitEnergy {
	static func fromSymbol(_ symbol: String) -> UnitEnergy {
		switch symbol {
		case "kCal":
			return .kilocalories
		default:
			return UnitEnergy(symbol: symbol)
		}
	}
}

extension Density {
	fileprivate static func fromString(_ string: String) -> Density {
		// Example: 5 g per 1 cup
		let components = string.split(separator: " ")

		let massValue = Double(components[0])!
		let massUnit: UnitMass = .fromSymbol(String(components[1]))
		let volumeValue = Double(components[3])!
		let volumeUnit: UnitVolume = .fromSymbol(String(components[4]))

		return Density(massValue, massUnit, per: volumeValue, volumeUnit)
	}
}

import SwiftUI

extension Unit {
	public var unitIcon: Image {
		if let iconProvider = self as? UnitIconProvider {
			return iconProvider.customUnitIcon
		}
		// Fallback to 'gauge' where no icon is specified
		return Image(systemName: "gauge")
	}
}

// Allow Unit subclasses to provide icon overrides
private protocol UnitIconProvider {
	var customUnitIcon: Image { get }
}

extension UnitMass: UnitIconProvider {
	var customUnitIcon: Image {
		Image(systemName: "scalemass.fill")
	}
}

extension UnitVolume: UnitIconProvider {
	var customUnitIcon: Image {
		switch symbol {
		// Icons included in the asset catalog
		case "cup", "qt", "tbsp", "tsp", "gal":
			return Image(symbol)
		default:
			return Image(systemName: "drop.fill")
		}
	}
}

private let kilocaloriesInFat: Double = 9
private let kilocaloriesInCarb: Double = 4
private let kilocaloriesInProtein: Double = 4

public struct CalorieBreakdown {
	public let percentFat: Double
	public let percentCarbohydrate: Double
	public let percentProtein: Double

	public var labeledValues: [(String, Double)] {
		return [
			("Protein", percentProtein),
			("Fat", percentFat),
			("Carbohydrates", percentCarbohydrate)
		]
	}
}

extension NutritionFact {
	public var kilocaloriesFromFat: Double {
		totalFat.converted(to: .grams).value * kilocaloriesInFat
	}

	public var kilocaloriesFromCarbohydrates: Double {
		(totalCarbohydrates - dietaryFiber).converted(to: .grams).value * kilocaloriesInCarb
	}

	public var kilocaloriesFromProtein: Double {
		protein.converted(to: .grams).value * kilocaloriesInProtein
	}

	public var kilocalories: Double {
		kilocaloriesFromFat + kilocaloriesFromCarbohydrates + kilocaloriesFromProtein
	}

	public var energy: Measurement<UnitEnergy> {
		return Measurement<UnitEnergy>(value: kilocalories, unit: .kilocalories)
	}

	public var calorieBreakdown: CalorieBreakdown {
		let totalKilocalories = kilocalories
		let percentFat = kilocaloriesFromFat / totalKilocalories * 100
		let percentCarbohydrate = kilocaloriesFromCarbohydrates / totalKilocalories * 100
		let percentProtein = kilocaloriesFromProtein / totalKilocalories * 100
		return CalorieBreakdown(
			percentFat: percentFat,
			percentCarbohydrate: percentCarbohydrate,
			percentProtein: percentProtein
		)
	}
}

extension Ingredient {
	var nutritionFact: NutritionFact? {
		NutritionFact.lookupFoodItem(id, forVolume: .cups(1))
	}
}

struct MeasuredIngredient: Identifiable, Codable {
	var ingredient: Ingredient
	var measurement: Measurement<UnitVolume>

	init(_ ingredient: Ingredient, measurement: Measurement<UnitVolume>) {
		self.ingredient = ingredient
		self.measurement = measurement
	}

	// Identifiable
	var id: Ingredient.ID { ingredient.id }
}

extension MeasuredIngredient {
	var kilocalories: Int {
		guard let nutritionFact = nutritionFact else {
			return 0
		}
		return Int(nutritionFact.kilocalories)
	}

	// Nutritional information according to the quantity of this measurement.
	var nutritionFact: NutritionFact? {
		guard let nutritionFact = ingredient.nutritionFact else {
			return nil
		}
		let mass = measurement.convertedToMass(usingDensity: nutritionFact.density)
		return nutritionFact.converted(toMass: mass)
	}
}

extension Ingredient {
	func measured(with unit: UnitVolume) -> MeasuredIngredient {
		MeasuredIngredient(self, measurement: Measurement(value: 1, unit: unit))
	}
}

extension MeasuredIngredient {
	func scaled(by scale: Double) -> MeasuredIngredient {
		return MeasuredIngredient(ingredient, measurement: measurement * scale)
	}
}


struct Smoothie: Identifiable, Codable {
	var id: String
	var title: String
	var description: AttributedString
	var measuredIngredients: [MeasuredIngredient]
}

extension Smoothie {
	init?(for id: Smoothie.ID) {
		guard let smoothie = Smoothie.all().first(where: { $0.id == id }) else { return nil }
		self = smoothie
	}

	var kilocalories: Int {
		let value = measuredIngredients.reduce(0) { total, ingredient in total + ingredient.kilocalories }
		return Int(round(Double(value) / 10.0) * 10)
	}

	var energy: Measurement<UnitEnergy> {
		return Measurement<UnitEnergy>(value: Double(kilocalories), unit: .kilocalories)
	}

	// The nutritional information for the combined ingredients
	var nutritionFact: NutritionFact {
		let facts = measuredIngredients.compactMap { $0.nutritionFact }
		guard let firstFact = facts.first else {
			print("Could not find nutrition facts for \(title) — using `banana`'s nutrition facts.")
			return .banana
		}
		return facts.dropFirst().reduce(firstFact, +)
	}

	var menuIngredients: [MeasuredIngredient] {
		measuredIngredients.filter { $0.id == Ingredient.orange.id }
	}

	func matches(_ string: String) -> Bool {
		string.isEmpty ||
		title.localizedCaseInsensitiveContains(string) ||
		menuIngredients.contains {
			$0.ingredient.name.localizedCaseInsensitiveContains(string)
		}
	}
}

extension Smoothie: Hashable {
	static func == (lhs: Smoothie, rhs: Smoothie) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}


// MARK: - Smoothie List
extension Smoothie {
	@SmoothieArrayBuilder
	static func all() -> [Smoothie] {
		Smoothie(id: "papas-papaya", title: String(localized: "Papa's Papaya", comment: "Smoothie name")) {
			AttributedString(localized: "Papa would be proud of you if he saw you drinking this!", comment: "Papa's Papaya smoothie description")

			Ingredient.orange.measured(with: .cups)
		}
	}

	// Used in previews.
	static var berryBlue: Smoothie { Smoothie(for: "berry-blue")! }
	static var kiwiCutie: Smoothie { Smoothie(for: "kiwi-cutie")! }
	static var hulkingLemonade: Smoothie { Smoothie(for: "hulking-lemonade")! }
	static var mangoJambo: Smoothie { Smoothie(for: "mango-jambo")! }
	static var tropicalBlue: Smoothie { Smoothie(for: "tropical-blue")! }
	static var lemonberry: Smoothie { Smoothie(for: "lemonberry")! }
	static var oneInAMelon: Smoothie { Smoothie(for: "one-in-a-melon")! }
	static var thatsASmore: Smoothie { Smoothie(for: "thats-a-smore")! }
	static var thatsBerryBananas: Smoothie { Smoothie(for: "thats-berry-bananas")! }
}

extension Smoothie {
	init(id: Smoothie.ID, title: String, @SmoothieBuilder _ makeIngredients: () -> (AttributedString, [MeasuredIngredient])) {
		let (description, ingredients) = makeIngredients()
		self.init(id: id, title: title, description: description, measuredIngredients: ingredients)
	}
}
