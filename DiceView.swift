import SwiftUI

struct DiceView: View {
    @State var generated: [Int] = []
	@State var displayDies: [Int] = []
	@State var history: [Int] = []
    let columns = [GridItem(.adaptive(minimum: 50, maximum: 75))]
    @State var dies: Double = 1
    @State var multiDieMode = "plus"
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
                    Picker(selection: $multiDieMode, label: Text("")) {
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
								.font(.subheadline)
						} else {
							LazyVGrid(columns: columns, spacing: 10) {
								
								ForEach(0..<displayDies.count, id: \.self) { index in
									Image(systemName: "die.face.\(index > displayDies.count ? Int.random(in: 1...6) : displayDies[index])")
										.resizable()
										.scaledToFit()
										.frame(width: 50, height: 50)
									if index != displayDies.count {
										Image(systemName: multiDieMode)
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
			Section("Result") {
				Button("Generate") {
					generated = rngN6DieArr(dies: Int(dies))
					displayDies = generated
				}
				Text(String(arrCombine(arr: generated, combineMode: multiDieMode)))
					.bold()
					.font(.largeTitle)
				}
				Button("Test1") {
					generated = [1, 2]
					multiDieMode = "plus"
				}
				Button("Test2") {
					generated = [1, 2]
					multiDieMode = "multiply"
				}
			}
		}.animation(.spring, value: displayDies)
	}
}

#Preview {
	DiceView()
}
