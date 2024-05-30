import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationSplitView {
                List {
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
					} label: {
						HStack {
							Text("Password")
							Spacer()
							Image(systemName: "ellipsis.rectangle")
						}
					}
					NavigationLink {
						PasswordView()
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
