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
                            Image(systemName: "die.face.6.fill")
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
