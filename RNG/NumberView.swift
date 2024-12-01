//
//  RNGView.swift
//  RNG
//
//  Created by Nihaal on 09/10/2024.
//

import SwiftUI

struct NumberView: View {
	@State var low: String = "1"
	@State var high: String = "10"
	@State var exclude: String = "none"
	@State var generated = ""
	@State var prevGen = ""
	@State var generatedInt: Int = 0
	@State var prevGenInt: Int = 0
	@State var dispResult = 0
	var body: some View {
		List {
			HStack {
				Spacer()
				TextField("From", text: $low)
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.multilineTextAlignment(.center)
				Image(systemName: "minus")
					.resizable()
					.scaledToFit()
					.bold()
					.frame(width: 20)
				TextField("To", text: $high)
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.multilineTextAlignment(.center)
				Spacer()
			}
			Section("Exclude") {
				Picker(selection: $exclude, label: Text("")) {
					Text("Start").tag("start")
					Text("None").tag("none")
					Text("End").tag("end")
					Text("Both").tag("both")
				}
				.pickerStyle(.segmented)
			}
			Section("Description") {
				Text(describeInputs(min: low, max: high, exclude: exclude))
					.font(.headline)
					.fontWeight(.heavy)
					.frame(alignment: .center)
			}
		}
		Text(generated)
			.font(.system(size: 50, weight: .bold))
			.foregroundColor(.gray)
			.frame(height: 40)
		Button {
			prevGen = generated
			generated = rng3(min: low, max: high, exclude: exclude)
		} label: {
			Text("Generate")
				.padding(.horizontal)
				.font(.system(size: 25, weight: .bold))
		}
		.buttonStyle(BorderedProminentButtonStyle())
		.cornerRadius(15)
		.padding(.vertical)
	}
}

func describeInputs(min: String, max: String, exclude: String) -> String {
	let validExcludes = ["start", "none", "end", "both"]
	guard validExcludes.contains(exclude) else {
		print("invalid exclude: " + exclude)
		return "invalid exclude: " + exclude
	}
	
	var result = "Any number from "
	result += min
	result += " to "
	result += max
	
	if min == "" || max == "" {
		return "Enter values above."
	}
	switch exclude {
		case "start":
			result += ", excluding \(min)"
		case "end":
			result += ", excluding \(max)"
		case "both":
			result += ", excluding \(min) and \(max)"
		case "none":
			break
		default:
			result = "invalid 'exclude'"
	}
	return result + "."
}

func rng3(min: String, max: String, exclude: String) -> String {
	var newMin = Int(min)!
	var newMax = Int(max)!
	guard newMin <= newMax else {
		return "Invalid inputs"
	}
	guard newMin != newMax else {
		return "No numbers"
	}
	guard newMin + 1 != newMax else {
		return "No numbers"
	}
	if exclude == "both" {
		newMax -= 1
		newMin += 1
	} else if exclude == "start" {
		newMin += 1
	} else if exclude == "end" {
		newMax -= 1
	}
	return String(rng(min: newMin, max: newMax))
}

#Preview {
	NumberView()
}
