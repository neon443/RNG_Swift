//
//  RNGView.swift
//  RNG
//
//  Created by Nihaal on 09/10/2024.
//










//fix date created
//TODO: readd ios 16 support
//TODO: try to use inject







import SwiftUI

struct NumberView: View {
	@State var low: String = "1"
	@State var high: String = "10"
	@State var exclude: String = "none"
	@State var generated = "5"
	@State var prevGen = ""
	@State var generatedInt: Int = 0
	@State var prevGenInt: Int = 0
	@State var dispResult = 5
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
			}
		}
		Text(String(dispResult))
			.font(.system(size: 75, weight: .bold))
			.foregroundColor(.gray)
			.frame(height: 50)
		Button {
			prevGen = generated
			generated = rng2(min: low, max: high, exclude: exclude)
			prevGenInt = Int(prevGen)!
			generatedInt = Int(generated)!
			if prevGenInt < generatedInt {
				for _ in prevGenInt...generatedInt {
					dispResult += 1
					//sleep( UInt32( 1 / (generatedInt - prevGenInt) ) )
				}
			} else if prevGenInt > generatedInt {
				for _ in generatedInt...prevGenInt {
					dispResult -= 1
					//sleep( UInt32( 1 / (prevGenInt - generatedInt) ) )
				}
			} else if prevGenInt == generatedInt {
				dispResult = generatedInt
			}
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

func describeInputs(min: String, max: String, exclude: String) -> String {
	let validExcludes = ["start", "end", "both", "none"]
	guard validExcludes.contains(exclude) else {
		print("invalid exclude: " + exclude)
		return "invalid exclude: " + exclude
	}
	
	var result = "Any number from "
	result += min != "" ? min : "_"
	result += " to "
	result += max != "" ? max : "_"
	
	if min == "" || max == "" {
		return "Enter values above."
	} else {
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
	}
	result += "."
	return result
}

enum rng2Errors: Error {
	case h
}

func rng2(min: String, max: String, exclude: String) -> String {
	guard min != "" || max != "" else {
		return "Enter values above."
	}
	guard var minInt = Int(min) else {
		print("invalid min")
		return "-1"
	}
	guard var maxInt = Int(max), maxInt >= minInt else {
		print("invalid max or is less than min")
		return "-1"
	}
	guard exclude != "both", min != max else {
		print("excluding both but min == max")
		return "No possible numbers, both bounds equal."
	}
	let minIntPlus1 = minInt + 1
	guard exclude != "both", minIntPlus1 != maxInt else {
		print("excluding both but min +1 == max")
		return "No possible numbers."
	}
	var generated = 0
	if exclude == "both" {
		maxInt -= 1
		minInt += 1
	} else if exclude == "start" {
		minInt += 1
	} else if exclude == "end" {
		maxInt -= 1
	}
	generated = rng(min: minInt, max: maxInt)
	return String(generated)
}

#Preview {
	NumberView()
}
