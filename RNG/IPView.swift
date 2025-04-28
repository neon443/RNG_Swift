//
//  IPView.swift
//  RNG
//
//  Created by Nihaal Sharma on 09/01/2025.
//

import SwiftUI

struct IPView: View {
	@State var ipType = 4
	@State var ip: String = ""
	var body: some View {
		List {
			Picker("IP Version", selection: $ipType) {
				Text("IPv4").tag(4)
				Text("IPv6").tag(6)
			}
			.pickerStyle(SegmentedPickerStyle())
		}
		Text(ip)
			.font(.system(size: 30))
			.foregroundColor(.gray)
			.frame(height: 40)
			.contentTransition(.numericText())
			.monospaced()
		Button {
			withAnimation {
				ip = generateIPv(ipType)
			}
		} label: {
			Text("Generate")
				.padding(.horizontal)
				.font(.system(size: 25))
				.monospaced()
		}
		.buttonStyle(BorderedProminentButtonStyle())
		.cornerRadius(15)
		.padding(.vertical)
	}
}

func generateIPv(_ type: Int) -> String {
	let randomNumber = Int.random(in: 0..<256)
	let randomNumber2 = Int.random(in: 0..<256)
	let randomNumber3 = Int.random(in: 0..<256)
	let randomNumber4 = Int.random(in: 0..<256)
	switch type {
	case 4:
		return "\(randomNumber).\(randomNumber2).\(randomNumber3).\(randomNumber4)"
	case 6:
		for _ in 0..<6 {
			for _ in 0..<4 {
				let randomChar = Int.random(in: 0..<10)
				print(randomChar)
			}
		}
		// eg: fd7a:115c:a1e0:0000:6501:6f07
		return "unimplemenented"
	default:
		return ""
	}
}

#Preview {
    IPView()
}
