//
//  DiceView.swift
//  RNG
//
//  Created by Nihaal on 30/05/2024.
//

import SwiftUI

struct DiceView: View {
	@State var advanced: Bool = false
	@State var generated: [Int] = []
	@State var displayDies: [Int] = []
	@State var displayMultiDieMode = ""
	@State var multiDieMode = "plus"
	@State var result: UInt = 0
	@State var resultDescription = ""
	let columns = [GridItem(.adaptive(minimum: 25, maximum: 75))]
	@State var dies: Double = 2
	
	var body: some View {
		VStack {
			List {
				Section("Number of die") {
					Toggle(isOn: $advanced) {
						Text("Advanced Mode")
					}
					HStack {
						Text(String(Int(dies)))
							.font(.system(size: 20, weight: .heavy))
							.frame(width: ((dies > 99) ? 40 : (dies > 9) ? 30 : 20))
						Divider()
						Text("1")
						if advanced {
							Slider(value: $dies, in: 1...100, step: 1)
							Text("100")
						} else {
							Slider(value: $dies, in: 1...20, step: 1)
							Text("20")
						}
					}
				}
				Section("Multi die mode") {
					Picker(selection: $multiDieMode, label: Text("ioug")) {
						Image(systemName: "plus").tag("plus")
						Image(systemName: "multiply").tag("multiply")
					}.pickerStyle(SegmentedPickerStyle())
				}
				Section("Visual") {
					if displayDies.isEmpty {
						Text("Tap Generate to get started!")
							.font(.headline)
							.fontWeight(.heavy)
							.frame(alignment: .center)
					} else {
						LazyVGrid(columns: columns, spacing: 2.5) {
							ForEach(0..<displayDies.count, id: \.self) { index in
								Image(systemName: "die.face.\(displayDies[index])")
									.resizable()
									.scaledToFit()
									.frame(width: 40, height: 40)
								if index != displayDies.count-1 {
									Image(systemName: displayMultiDieMode)
										.resizable()
										.scaledToFit()
										.frame(width: 15, height: 15)
								}
							}
						}
					}
				}
			}
			Text(String(result))
				.font(.system(size: 50, weight: .bold))
				.foregroundColor(.gray)
				.frame(height: 40)
			Text(resultDescription)
				.frame(height: 10)
				.font(.system(size: 10))
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
		return ""
	} else {
		if combineMode == "plus" {
			symbol = "+"
		} else if combineMode == "multiply" {
			symbol = "x"
		}
		for i in 0...len {
			if i == len {
				result += String(inp[i])
			} else {
				result += String(inp[i]) + symbol
			}
		}
		return result
	}
}

#Preview {
	DiceView()
}
