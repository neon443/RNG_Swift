import SwiftUI

struct CustomRNGView: View {
    @State var rangeL: String = ""
    @State var rangeH: String = ""
    @State var show = false
    var body: some View {
		Text("Unimplemented")
        Form {
            HStack {
                TextField("From", text: $rangeL)
                    .keyboardType(.numberPad)
                Divider()
                TextField("To", text: $rangeH)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Any number")
                Divider()
                HStack {
                    Text("From: ")
                    Text(rangeL)
                    Spacer()
                }
                HStack {
                    Text("To: ")
                    Text(rangeH)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CustomRNGView()
}
