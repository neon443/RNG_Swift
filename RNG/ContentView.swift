//
//  ContentView.swift
//  RNG
//
//  Created by Nihaal on 09/10/2024.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			NavigationSplitView {
				List {
					Section("Generate...") {
						NavigationLink {
							NumberView()
								.navigationTitle("Numbers")
						} label: {
							HStack {
								Text("Numbers")
								Spacer()
								Image(systemName: "textformat.123")
							}
						}
						NavigationLink {
							DiceView()
								.navigationTitle("Die")
						} label: {
							HStack {
								Text("Die")
								Spacer()
								Image(systemName: "die.face.1")
								Image(systemName: "die.face.2.fill")
								Image(systemName: "die.face.3")
								Image(systemName: "die.face.4.fill")
								Image(systemName: "die.face.5")
								Image(systemName: "die.face.6.fill")
							}
						}
						NavigationLink {
							PasswordView()
								.navigationTitle("Passwords")
						} label: {
							HStack {
								Text("Passwords")
								Spacer()
								Image(systemName: "rectangle.and.pencil.and.ellipsis")
							}
						}
						NavigationLink() {
							IPView()
						} label: {
							HStack {
								Text("IP Adresses")
								Spacer()
								Image(systemName: "network")
							}
						}
						NavigationLink() {
							MACView()
						} label: {
							HStack {
								Text("MAC Adresses")
								Spacer()
								Image(systemName: "antenna.radiowaves.left.and.right")
							}
						}
					}
					.navigationTitle("RNG")
					.navigationBarTitleDisplayMode(.inline)
				}
			} detail: {
				Image(systemName: "dice.fill")
			}
		}
	}
}

#Preview {
	ContentView()
}
