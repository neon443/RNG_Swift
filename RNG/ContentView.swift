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
					NavigationLink {
						NumberView()
							.navigationTitle("Random Number Generator")
					} label: {
						HStack {
							Text("Random Number Generator")
							Spacer()
							Image(systemName: "textformat.123")
						}
					}
					NavigationLink {
						DiceView()
							.navigationTitle("Dice")
					} label: {
						HStack {
							Text("Dice")
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
							.navigationTitle("Password")
					} label: {
						HStack {
							Text("Password")
							Spacer()
							Image(systemName: "rectangle.and.pencil.and.ellipsis")
						}
					}
				}
				.navigationTitle("RNG")
				.navigationBarTitleDisplayMode(.inline)
			} detail: {
				Image(systemName: "dice.fill")
			}
		}
	}
}
