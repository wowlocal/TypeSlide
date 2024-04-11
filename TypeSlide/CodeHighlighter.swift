//
//  StretchTextView.swift
//  TypeSlide
//
//  Created by Misha Nya on 06.04.2024.
//

import SwiftUI
import HighlightSwift

struct SwiftCodeHighlightView: View {
	@State var code: String

	init(code: String) {
		self.code = code
	}

	var body: some View {
		CodeText(code)
			.codeTextColors(.theme(.horizon))
			.codeTextMode(.language(.swift))
			.padding()
	}
}

#Preview {
	SwiftCodeHighlightView(code: """
		import SwiftUI

		struct ContentView: View {
			var body: some View {
				Text("Hello, World!")
					.padding()
			}
		}

		struct ContentView_Previews: PreviewProvider {
			static var previews: some View {
				ContentView()
			}
		}
		""")
		.padding()

}
