//
//  RNGApp.swift
//  RNG
//
//  Created by Nihaal on 24/05/2024.
//

import SwiftUI

@main
struct RNGApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

// array combiner, adds up all ints in an array
func totalIntArr(arr: [Int]) -> Int {
	var total = 0
	for num in arr {
		total += num
	}
	return total
}

// array combiner, adds up all doubles in an array
func totalDoubleArr(arr: [Double]) -> Double {
	var total: Double = 0
	for num in arr {
		total += num
	}
	return total
}

// array combiner, adds or multiplies all ints in an array
func arrCombine(arr: [Int], combineMode: String) -> Int {
	var output = 0
	if combineMode == "plus" {
		for num in arr {
			output += num
		}
	} else if combineMode == "multiply" {
		output = 1
		for num in arr {
			output *= num
		}
	} else {
		print("invalid combineMode '\(combineMode)'. must be 'plus' or 'multiply', returning 0")
		return 0
	}
	return output
}


func rng(min: Int, max: Int) -> Int {
	var rng = 0
	rng = Int.random(in: min...max)
	return rng
}

func rng6Die() -> Int {
	return Int.random(in: 1...6)
}

func rngCDie(min: Int, max: Int) -> Int {
	return Int.random(in: min...max)
}

func rngN6DieArr(dies: Int) -> [Int] {
	var output: [Int] = []
	for _ in 1...dies {
		output.append(rng6Die())
	}
	return output
}

func rngNCDie(dies: Int, min: Int, max: Int) -> [Int] {
	var output: [Int] = []
	for _ in 1...dies {
		output.append(rngCDie(min: min, max: max))
	}
	return output
}

func rngInt(len: Int) async -> Int {
	var resultI: Int = 0
	var latestElement = 0
	for _ in 1...len {
		latestElement = Int.random(in: 0...9)
		if latestElement == 0 {
			resultI *= 10
		} else {
			resultI *= 10
			resultI += latestElement
		}
	}
	return resultI
}

func rngString(len: Int) -> String {
	let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	return String((1..<len).map{ _ in letters.randomElement()! })
	
}

#Preview("ContentView") {
	ContentView()
}
