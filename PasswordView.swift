//
//  PasswordView.swift
//  RNG
//
//  Created by Nihaal on 30/05/2024.
//

//////////////////////////// IMPLEMENT A WORKING BUTTON
//////////////////////////// current one does nothing lol

import SwiftUI

struct PasswordView: View {
    @State var viewType = "simple"
    @State var passType = "code"
    @State var codeLen = 4
    @State var customLen: Double = 0
    @State var customLenStr = ""
    @State var generated = ""
    @State var result = ""
    @State var history: [Int] = []
    @State var showPassCodeWordHelpSheet = false

    var body: some View {
        VStack {
            List {
                Section("View mode") {
                    Picker("simple", selection: $viewType) {
                        Text("Simple").tag("simple")
                        Text("Advanced").tag("advanced")
                    }
                    .pickerStyle(.segmented)
                }
                Section("Generate a...") {
                    HStack {
                        Picker("code", selection: $passType) {
                            Text("Passcode").tag("code")
                            Text("Password").tag("word")
                        }
                        .pickerStyle(.segmented)
                    }
                    HStack {
                        Spacer()
                        Text("Only numbers 0-9")
                        Spacer()
                        Divider()
                        Spacer()
                        Text("Letters a-z, A-Z and numbers 0-9")
                        Spacer()    
                    }
                }
                Section("Length") {
                    Picker("", selection: $codeLen) {
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text(customLen == 0 ? "Custom" : String(Int(customLen))).tag(-1)
                    }
                    .pickerStyle(.segmented)
                    if codeLen == -1 {
                        HStack {
                            Slider(value: $customLen, in: 1...20, step: 1)
                            TextField("Enter a num", text: $customLenStr)
                                .keyboardType(.numberPad)
                                .onChange(of: customLen) { newValue in
                                    customLenStr = String(Int(customLen))    
                                }
                                .onChange(of: customLenStr) { newValue in
                                    customLen = Double(newValue)!
                                }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    } else {
                        
                    }
                }
				Section("Result") {
					HStack {
						Group {
							Spacer()
							Text(String(result))
							Spacer()
						}
					}
					HStack {
						Spacer()
						Text(String(generated))
							.font(.largeTitle)
							.bold()
						Spacer()
					}
                }
                Button("Generate") {
                    if viewType == "simple" {
                        if passType == "code" {
                            if codeLen == 4 {
                                generated = genPass(type: "4Int", min: nil, max: nil)
                            } else if codeLen == 6 {
								generated = genPass(type: "6Int", min: nil, max: nil)
                            }
                        } else if passType == "word" {
                            if codeLen == 4 {
								generated = genPass(type: "4String", min: nil, max: nil)
							} else if codeLen == 6 {
								generated = genPass(type: "6String", min: nil, max: nil)
							}
                        }
					} else if viewType == "word" {
						
					}
                }
            }
        }
    }
}

struct PassCodeWordHelpView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text(" ")
            HStack {
                Spacer()
                Text("Passcode")
                    .font(.headline)
                Spacer()
                Text("Password")
                    .font(.headline)
                Spacer()
            }
            HStack {
                List {
                    Text("iopgt")
                    Text("eiou")
                }
                .listStyle(GroupedListStyle())
                .padding(-10)
                List {
                    Text("wi")
                }
                .listStyle(GroupedListStyle())
                .padding(-10)
            }
        }
    }
}

func genPass(type: String, min: Int?, max: Int?) -> String {
    var result = ""
	if type == "4Int" {
		result = String(rngInt(len: 4))
	} else if type == "6Int" {
		result = String(rngInt(len: 6))
	} else if type == "4String" {
		result = rngString(len: 4)
	} else if type == "6String" {
		result = rngString(len: 6)
    } else if min != nil && max != nil {
        if type == "Int" {
            result = String(rngInt(len: max! - min!) + min!)
        } else if type == "String" {
            if min == nil {
                //if there no min, use max as length
                result = rngString(len: max!)
            } else {
                print("when type is String, leave min empty and use max as a length.")
                print("returning -1")
            }
        }
    } else {
        print("invalid input")
        print("type = Int: give min and max")
        print("type = String: min = nil, max = length")
        print("Preset: (type = 4Int/String, 6Int/String) and leave min, max = nil")
        print("  4Int: 0000-9999; 4 digit")
        print("  6Int: 000000-999999; 6 digit")
        print("  4String: a-z/0-9: _ _ _ _; 4 digit alphanumeric")
        print("  6String: a-z/0-9: _ _ _ _ _ _; 6 digit alphanumeric")
        print("returning -1")
		result = "-1"
    }
    return result
}

#Preview("PasswordView") {
    PasswordView()
}
#Preview("PassCodeWordHelpView") {
	PassCodeWordHelpView()
}
