//
//  DiceView.swift
//  RNG
//
//  Created by Nihaal on 30/05/2024.
//

import SwiftUI

struct DiceView: View {
	@State var generated: [Int] = [0]
	@State var displayDies: [Int] = []
	@State var displayMultiDieMode = ""
	@State var multiDieMode = "plus"
	@State var result = 0
	@State var resultDescription = ""
	@State var history: [Int] = []
	let columns = [GridItem(.adaptive(minimum: 25, maximum: 75))]
	@State var dies: Double = 2
	var body: some View {
		VStack {
			List {
				Section("Number of die") {
					HStack {
						Text( String( Int(dies) ) )
							.font(.system(size: 25, weight: .bold))
						Divider()
						Text("1")
						Slider(value: $dies, in: 1...20, step: 1)
						Text("20")
					}
				}
				Section("Multi die mode") {
					Picker(selection: $multiDieMode, label: Text("ioug")) {
						Image(systemName: "plus").tag("plus")
						Image(systemName: "multiply").tag("multiply")
					}.pickerStyle(SegmentedPickerStyle())
				}
				Section("Visual") {
					HStack {
						Spacer()
						if displayDies.isEmpty {
							Text("Results are visualised here when you press the generate button")
								.font(.subheadline)
						} else {
							LazyVGrid(columns: columns, spacing: 10) {
								ForEach(0..<displayDies.count, id: \.self) { index in
									Image(systemName: "die.face.\(displayDies[index])")
										.resizable()
										.scaledToFit()
										.frame(width: 50, height: 50)
									if index != displayDies.count-1 {
										Image(systemName: displayMultiDieMode)
											.resizable()
											.scaledToFit()
											.frame(width: 10, height: 10)
									}
								}
							}.padding()
						}
					}
				}
			}
			Text(String(result))
				.font(.system(size: 75, weight: .bold))
				.foregroundColor(.gray)
				.frame(height: 50)
			Text(resultDescription)
				.frame(height: 20)
			Button {
				generated = rngN6DieArr(dies: Int(dies))
				displayDies = generated
				displayMultiDieMode = multiDieMode
				result = arrCombine(arr: generated, combineMode: multiDieMode)
				resultDescription = describeResult(inp: displayDies, combineMode: multiDieMode)
			} label: {
				Text("Generate")
					.padding(.horizontal)
					.font(.system(size: 25, weight: .bold))
			}
			.buttonStyle(BorderedProminentButtonStyle())
			.cornerRadius(15)
			.padding(.bottom)
		}
	}
}

func describeResult(inp: [Int], combineMode: String) -> String {
	let len = inp.count-1
	var result = ""
	var symbol = ""
	if inp.isEmpty {
		return "0"
	} else {
		if combineMode == "plus" {
			symbol = " + "
		} else if combineMode == "multiply" {
			symbol = " x "
		}
		for i in 0...len {
			if i == len {
				result += String(inp[i])
			} else {
				result += String(inp[i]) + symbol
			}
		}
		result += " = " + String(arrCombine(arr: inp, combineMode: combineMode))
		return result
	}
}

#Preview {
	DiceView()
}
