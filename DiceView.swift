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
    @State var dies: Double = 1
    var body: some View {
		VStack {
			List {
				Section("Number of die") {
					HStack {
						Text(String(Int(dies)))
						Slider(value: $dies, in: 1...10, step: 1)
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
						} else if displayDies.count != Int(dies) {
							Text("Press Generate")
								.font(.title)
						} else {
							LazyVGrid(columns: columns, spacing: 10) {
								ForEach(0..<displayDies.count, id: \.self) { index in
									Image(systemName: "die.face.\(index > displayDies.count ? Int.random(in: 1...6) : displayDies[index])")
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
						Spacer()
					}
				}
				Button("Generate") {
					generated = rngN6DieArr(dies: Int(dies))
					displayDies = generated
					displayMultiDieMode = multiDieMode
					result = arrCombine(arr: generated, combineMode: multiDieMode)
					resultDescription = describeResult(inp: displayDies, combineMode: multiDieMode)
				}
				Text(String(result))
					.bold()
					.font(.largeTitle)
				Text(resultDescription)
			}
		}
	}
}

func describeResult(inp: [Int], combineMode: String) -> String {
	var len = inp.count-1
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
