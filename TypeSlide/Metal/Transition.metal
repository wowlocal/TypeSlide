//
//  Transition.metal
//  TypeSlide
//
//  Created by Misha Nya on 16.04.2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 pixelate(float2 position, SwiftUI::Layer layer, float width) {
	if (width > 0) {
		return layer.sample(width * round(position / width));
	} else {
		return layer.sample(position);
	}
}
