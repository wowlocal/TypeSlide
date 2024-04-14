//
//  CodeSamples.swift
//  TypeSlide
//
//  Created by Misha Nya on 14.04.2024.
//

import Foundation

extension Samples {
	var identity1: String { """
@State var toggle: Bool

var body: some View {
 if toggle {
  Color.orange
   .frame(width: 300, height: 300)
 } else {
  Color.green
   .frame(width: 200, height: 200)
 }
}
""" }


	var identity0: String { """
@State var toggle: Bool

 var body: some View {
	 Color.orange
		 .frame(width: toggle ? 300 : 200)
 }
""" }


}
