//
//  PasswordView.swift
//  RNG
//
//  Created by Nihaal on 30/05/2024.
//

import SwiftUI

struct PasswordView: View {
	@State var selectedOptions: [PassOption] = []
	let options: [PassOption] = [
		PassOption(name: "0-9", chars: Array("0123456789")),
		PassOption(name: "a-z", chars: Array("abcdefghijklmnopqrstuvwxyz")),
		PassOption(name: "A-Z", chars: Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
	]
	@State var presetLen = 4
	@State var customLen = 8
	@State var generated = ""
	@State var result = ""
	@State var history: [Int] = []
	
	var body: some View {
		VStack {
			List {
				Text("Hello, world!")
					.font(.largeTitle)
					.foregroundColor(.white)
					.padding()
					.background(Color.blue)
					.padding()
					.background(Color.mint)
					.padding()
					.background(Color.green)
				
				Section("Include") {
					ForEach(options) { option in
						Toggle(isOn: Binding(
							get: {
								self.selectedOptions.contains(where: { $0.id == option.id })
							},
							set: { isSelected in
								if isSelected {
									self.selectedOptions.append(option)
								} else {
									self.selectedOptions.removeAll { $0.id == option.id }
								}
							}
						)) {
							Text(option.name)
						}
					}
				}
				
				Section("Length") {
					Picker("", selection: $presetLen) {
						Text("4").tag(4)
						Text("6").tag(6)
						Text("Custom: \(customLen)").tag(-1)
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				if presetLen == -1 {
					TextField("Custom", value: $customLen, formatter: NumberFormatter())
						.keyboardType(.numberPad)
						.frame(width: 50)
				}
				
				Text(String(result))
					.font(.system(size: 75, weight: .bold))
					.foregroundColor(.gray)
					.frame(height: 50)
				
				Text(String(generated))
					.font(.system(size: 75, weight: .bold))
					.foregroundColor(.gray)
					.frame(height: 50)
				
				Button {
					generated = genPass(selectdOpts: selectedOptions, len: (presetLen == -1 ? customLen : presetLen))
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
	}
}
struct Option: Identifiable {
	let id: Int
	let name: String
}

struct PassOption: Identifiable {
	var id = UUID()
	var name: String
	var chars: [Character]
}

func genPass(selectdOpts: [PassOption], len: Int) -> String {
	let characters = selectdOpts.flatMap { $0.chars    }
	
	guard !(characters.isEmpty) else {
		print("characters empty")
		return ""
	}
	
	return (0..<len).compactMap { _ in
		characters.randomElement()
	}
	.map { String($0) }
	.joined()
}

#Preview {
	PasswordView()
}
