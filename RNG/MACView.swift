//
//  IPView.swift
//  RNG
//
//  Created by Nihaal Sharma on 09/01/2025.
//

import Foundation
import SwiftUI

struct MACView: View {
	@State var mac: String = ""
	@State var maclook: String = ""
	@State var looking: Bool = false
	var body: some View {
		List {
			HStack {
				Label("Vendor", systemImage: "building.2.fill")
				Spacer()
				if looking {
					ProgressView()
				} else {
					Text(maclook)
						.bold()
				}
			}
		}
		
		Text(mac)
			.font(.system(size: 30))
			.foregroundColor(.gray)
			.frame(height: 40)
			.contentTransition(.numericText())
			.monospaced()
		Button {
			withAnimation {
				mac = generateMAC()
			}
			Task {
				looking = true
				maclook = await maclookup(mac)
				looking = false
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

func generateMAC() -> String {
	var output = ""
	for _ in 0..<6 {
		output.append(hex(Int.random(in: 0...15)).hex)
		output.append(hex(rng(min: 0, max: 15)).hex)
		output.append(":")
	}
	output.removeLast()
	return output
}

func maclookup(_ mac: String) async -> String {
	let url = URL(string: "https://api.macvendors.com/\(mac)")!
	var request = URLRequest(url: url)
	request.httpMethod = "GET"
	
	do {
		let (data, _) = try await URLSession(configuration: .ephemeral).data(for: request)
		let result = String(data: data, encoding: .utf8) ?? "Lookup Error"
		if result.contains("{") {
			let dict = try JSONDecoder().decode([String: [String: String]].self, from: data)
			if let dict = dict["errors"] {
				return "\(dict["detail"]!)"
			}
		}
		return result
	} catch {
		print(error.localizedDescription)
		return "Lookup Error"
	}
}

class hex {
	@Published var hex: String
	init(_ int: Int) {
		switch int {
		case 16...Int.max:
			self.hex = "F"
		case Int.min...(-1):
			self.hex = "0"
			
		case 10:
			self.hex = "A"
		case 11:
			self.hex = "B"
		case 12:
			self.hex = "C"
		case 13:
			self.hex = "D"
		case 14:
			self.hex = "E"
		case 15:
			self.hex = "F"
			
		case 0...15:
			self.hex = "\(int)"
			
		default:
			self.hex = "0"
		}
		self.hex = self.hex.lowercased()
	}
}
#Preview {
	MACView()
}
